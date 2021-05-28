FROM nvcr.io/nvidia/pytorch:20.02-py3

RUN apt-get -y update
RUN DEBIAN_FRONTEND='noninteractive' apt-get -y install libopencv-dev

WORKDIR /yolo/

COPY ./3rdparty /yolo/3rdparty
COPY ./cmake    /yolo/cmake
COPY ./include  /yolo/include
COPY ./src      /yolo/src
COPY ./*_yolov4.sh     /yolo/
COPY ./Makefile /yolo/.

RUN make

COPY ./cfg      /yolo/cfg
COPY ./weights  /yolo/weights
COPY ./*.py     /yolo/
COPY ./run.sh   /yolo/

CMD bash run.sh

# docker build -f docker/Dockerfile -t ernestlwt/yolov4:tiny .
# docker run --rm --name yolov4-tiny -it -v /home/ernestlwt/data/coco/:/data/ -v /home/ernestlwt/workspace/github/darknet/config/:/yolo/config/ --shm-size=64g ernestlwt/yolov4:tiny