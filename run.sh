#! /bin.bash

if [ "$YOLO_MODE" == "train" ]; then
    ./darknet detector train /yolo/config/data.cfg /yolo/config/yolov4-tiny.cfg /yolo/weights/yolov4-tiny.weights -out yolov4-tiny 
elif [ "$YOLO_MODE" == "valid" ]; then
    ./darknet detector valid /yolo/config/data.cfg /yolo/config/yolov4-tiny.cfg /yolo/weights/yolov4-tiny.weights -out yolov4-tiny
else
    echo "YOLO_MODE not set to train/valid/serve. Exiting"
fi
