import cv2
import os
import numpy as np
import time
from PIL import Image, ImageStat

#im = Image.open("../img/000002.jpg")
#print(im.format, im.size, im.mode)
#st = ImageStat.Stat(im)
#print(st.count)
#print(st.mean)
#print(st.median)


# Face detection
imagePath = "../img/001032.jpg"
cascPath = "haarcascade_frontalface_default.xml"
faceCascade = cv2.CascadeClassifier(cascPath)

image = cv2.imread(imagePath)
imgray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Detect faces in the image
faces = faceCascade.detectMultiScale(
    imgray,
    scaleFactor=1.1,
    minNeighbors=5,
    minSize=(30, 30),
    flags = cv2.CASCADE_SCALE_IMAGE
)

print "Found {0} faces!".format(len(faces))

# Draw a rectangle around the faces
for (x, y, w, h) in faces:
    print x
    print y
    print w
    print h
    cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)

cv2.imshow("Faces found", image)

ret, thresh = cv2.threshold(imgray, 127, 255, 0)
im2, contours, hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
cnt = contours[0]
M = cv2.moments(cnt)
print "M"
print M
print "CNT"
print cnt
area = cv2.contourArea(cnt)
print "Area"
print area

matrix_test = None
for image in os.listdir('path_to_dir'):
    imgraw = cv.imread(os.path.join('path_to_dir', image), 0)
    imgvector = imgraw.reshape(128*128)
    try:
        matrix_test = np.vstack((matrix_test, imgvector))
    except:
        matrix_test = imgvector

# PCA
mean, eigenvectors = cv.PCACompute(matrix_test, np.mean(matrix_test, axis=0).reshape(1,-1))
print mean
print eigenvectors

time.sleep(1000)
