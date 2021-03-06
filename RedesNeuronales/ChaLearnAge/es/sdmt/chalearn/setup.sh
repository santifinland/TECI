# Get Neural network files
wget https://raw.githubusercontent.com/santifinland/TECI/master/RedesNeuronales/ChaLearnAge/es/sdmt/chalearn/FaceDetector.py
wget https://raw.githubusercontent.com/santifinland/TECI/master/RedesNeuronales/ChaLearnAge/es/sdmt/chalearn/perceptron.py
wget https://raw.githubusercontent.com/santifinland/TECI/master/RedesNeuronales/ChaLearnAge/es/sdmt/chalearn/Munging.R
wget https://raw.githubusercontent.com/santifinland/TECI/master/RedesNeuronales/ChaLearnAge/es/sdmt/chalearn/Point.py
wget https://raw.githubusercontent.com/santifinland/TECI/master/RedesNeuronales/ChaLearnAge/es/sdmt/chalearn/__init__.py

# Get gt files
curl -L -o train1.csv https://www.dropbox.com/s/ivaat4kticvbrkx/train1.csv?dl=1
curl -L -o validate1.csv https://www.dropbox.com/s/eyg6b6zokt3ivio/validate1.csv?dl=1
curl -L -o validate2.csv https://www.dropbox.com/s/hkxgzu0pjmt7ue8/validate2.csv?dl=1
curl -L -o validate3.csv https://www.dropbox.com/s/dpe5s5spszjgbex/validate3.csv?dl=1
curl -L -o train2.csv https://www.dropbox.com/s/5psil7suoc92r15/train2.csv?dl=1
curl -L -o train3.csv https://www.dropbox.com/s/oe2ypune44hgmvb/train3.csv?dl=1
curl -L -o test.csv https://www.dropbox.com/s/5eabyb8dcq3jjow/test.csv?dl=1
curl -L -o proportionnose.csv https://www.dropbox.com/s/sbht8iywh2whrpy/proportionnose.csv?dl=1
curl -L -o distancenoseeye.csv https://www.dropbox.com/s/pfcp1gdblsi6q6l/distancenoseeye.csv?dl=1
curl -L -o distancemouthnose.csv https://www.dropbox.com/s/jg27zne4eq0r2rf/distancemouthnose.csv?dl=1


# Get haarscade masks
wget https://raw.githubusercontent.com/Itseez/opencv/master/data/haarcascades/haarcascade_frontalface_default.xml
wget https://raw.githubusercontent.com/angus-ai/angus-service-facedetection/master/angus/services/resources/classifiers/haarcascade_mcs_mouth.xml
wget https://raw.githubusercontent.com/Itseez/opencv/master/data/haarcascades/haarcascade_smile.xml
wget https://raw.githubusercontent.com/Itseez/opencv/master/data/haarcascades/haarcascade_righteye_2splits.xml
wget https://raw.githubusercontent.com/Itseez/opencv/master/data/haarcascades/haarcascade_lefteye_2splits.xml
wget https://raw.githubusercontent.com/angus-ai/angus-service-facedetection/master/angus/services/resources/classifiers/haarcascade_mcs_nose.xml
wget https://raw.githubusercontent.com/Itseez/opencv/master/data/haarcascades/haarcascade_lowerbody.xml
wget https://raw.githubusercontent.com/angus-ai/angus-service-facedetection/master/angus/services/resources/classifiers/haarcascade_mcs_rightear.xml
wget https://raw.githubusercontent.com/angus-ai/angus-service-facedetection/master/angus/services/resources/classifiers/haarcascade_mcs_leftear.xml


