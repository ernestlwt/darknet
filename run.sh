#! /bin.bash

if [ "$YOLO_MODE" == "train" ]; then
    ./darknet detector train /yolo/config/data.cfg /yolo/config/yolov4-tiny.cfg /yolo/weights/yolov4-tiny.weights -out yolov4-tiny 
elif [ "$YOLO_MODE" == "valid" ]; then
    ./darknet detector valid /yolo/config/data.cfg /yolo/config/yolov4-tiny.cfg /yolo/weights/yolov4-tiny.weights -out yolov4-tiny
elif [ "$YOLO_MODE" == "serve" ]; then
    uvicorn server.api_server:app --host 0.0.0.0 --port 8000
else
    echo "YOLO_MODE not set to train/valid/serve. Exiting"
fi
