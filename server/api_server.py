import darknet

from fastapi import FastAPI, File, UploadFile

import cv2
import numpy as np
import io

app = FastAPI()

network, class_names, class_colors = darknet.load_network(
    "/yolo/config/yolov4-tiny.cfg",
    "/yolo/config/data.cfg",
    "/yolo/weights/yolov4-tiny.weights",
    batch_size=1
)

def image_detection(cv2_img, network, class_names, thresh=.3):
    # Darknet doesn't accept numpy images.
    # Create one with image we reuse for each detect
    width = darknet.network_width(network)
    height = darknet.network_height(network)
    darknet_image = darknet.make_image(width, height, 3)

    image_rgb = cv2.cvtColor(cv2_img, cv2.COLOR_BGR2RGB)
    image_resized = cv2.resize(image_rgb, (width, height), interpolation=cv2.INTER_LINEAR)

    darknet.copy_image_from_bytes(darknet_image, image_resized.tobytes())
    detections = darknet.detect_image(network, class_names, darknet_image, thresh=thresh)
    return detections

@app.post("/predict")
async def predict_picture(file: UploadFile = File(...)):

    image = await file.read()

    img = cv2.imdecode(np.fromstring(image, np.uint8), 1)
    prediction = image_detection(img, network, class_names)
    return {"prediction": prediction}