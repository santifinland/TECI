
import cv2
import numpy as np
from PIL import Image
from numpy import *
import pylab
import time
import math
import sys, traceback


class FaceDetector:

    def __init__(self):
        self.cascPathFace = "haarcascade_frontalface_default.xml"
        self.cascPathMouth = "haarcascade_mcs_mouth.xml"
        self.cascPathSmile = "haarcascade_smile.xml"
        self.cascPathRightEye = "haarcascade_righteye_2splits.xml"
        self.cascPathLeftEye = "haarcascade_lefteye_2splits.xml"
        self.cascPathNose = "haarcascade_mcs_nose.xml"
        self.cascPathBody = "haarcascade_lowerbody.xml"
        self.pixels = 100.0
        self.faces = 400.0
        self.facesValidate = 10.0
        self.fileTrain = "train_gtregre1.csv"
        self.fileValidate = "train_gtregre2.csv"

    def getimage(self, path):
        image = cv2.imread(path)
        return cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    def getimagefeature(self, image, cascade_xml):
        cascade = cv2.CascadeClassifier(cascade_xml)
        features = cascade.detectMultiScale(
            image,
            scaleFactor=1.1,
            minNeighbors=5,
            minSize=(3, 3),
            flags = cv2.CASCADE_SCALE_IMAGE)
        area = 0
        new_image = image
        for (x, y, w, h) in features:
            current_area = w * h
            if (current_area > area):
                area = current_area
                m = max(h, w)
                new_image = image[y:y+m, x:x+m]
        return new_image

    def getmouth(self, path):
        return self.getimagefeature(path, self.cascPathMouth)

    def getbody(self, path):
        return self.getimagefeature(path, self.cascPathBody)

    def getsmile(self, path):
        return self.getimagefeature(self.getface(path), self.cascPathSmile)

    def getlefteye(self, path):
        return self.getimagefeature(path, self.cascPathLeftEye)

    def getrighteye(self, image):
        return self.getimagefeature(image, self.cascPathRightEye)

    def getnose(self, image):
        return self.getimagefeature(image, self.cascPathNose)

    def getface(self, image):
        return self.getimagefeature(image, self.cascPathFace)

    def resize(self, image, size):
        #print "====="
        #print size
        #print image.shape[0]
        #print image.shape[1]
        #print "*****"
        if image.shape[0] < image.shape[1]:
            #print "siempre"
            #r = float(size) / image.shape[0]
            #dim = (int(size), int(image.shape[1] * r))
            #print dim
            return cv2.resize(image, (int(size), int(size)), interpolation=cv2.INTER_AREA)
        else:
            #print "nuevo"
            #r = float(size) / image.shape[1]
            #dim = (int(size), int(image.shape[0] * r))
            #print dim
            return cv2.resize(image, (int(size), int(size)), interpolation=cv2.INTER_AREA)

    def centercrop(self, image, size):
        return image[0:size, 0:size]

    def image2vector(self, image):
        return [x for x in image.flatten()]

    def rawface2vector(self, path):
        image = self.getimage(path)
        image = self.getface(image)
        image = self.resize(image, self.pixels)
        # Smile
        #smile = self.image2vector(self.getsmile(image))
        #nose = self.image2vector(self.getnose(image))
        #righteye = self.image2vector(self.getrighteye(image))
        #lefteye = self.image2vector(self.getlefteye(image))
        #smile = self.getsmile(image)
        #nose = self.getnose(image)
        #righteye = self.getrighteye(image)
        #lefteye = self.getlefteye(image)
        image = self.image2vector(image)
        #areaface = image.shape[0] * image.shape[1]
        #areasmile = 0 if smile.shape[0] * smile.shape[1] * 1.0 / areaface == 1 else smile.shape[0] * smile.shape[1] * 1.0 / areaface
        #areanose = 0 if nose.shape[0] * nose.shape[1] * 1.0 / areaface == 1 else nose.shape[0] * nose.shape[1] * 1.0 / areaface
        #arearighteye = 0 if righteye.shape[0] * righteye.shape[1] * 1.0 / areaface == 1 else righteye.shape[0] * righteye.shape[1] * 1.0 / areaface
        #arealefteye = arearighteye if lefteye.shape[0] * lefteye.shape[1] * 1.0 / areaface == 1 else lefteye.shape[0] * lefteye.shape[1] * 1.0 / areaface
        #vector = [areanose, arearighteye + arealefteye / 2]
        vector = image
        #print len(vector)
        #image = sum(image) / (1000.0 * 255)
        #print len(image)
        return vector

    def getage(self, path):
        image = path[-10:]
        f = file(self.fileTrain)
        l = f.readlines()
        f.close()
        age = 0.0
        for line in l:
            trio = line.split(",")
            if (trio[0] == image):
                age = trio[1]
        #return self.getAgeToSegment(age)
        #print age
        if int(float(age)) > int(69):
            #print "viejo"
            age = 70
        return age

    def getagecoded(self, age):
        p = [0] * int(71)
        p[int(math.ceil(float(age)))] = 1
        return p

    def getPat(self, validate = False):
        if validate == True:
            print "getgin validating"
            f = file(self.fileValidate)
        else:
            f = file(self.fileTrain)
        l = f.readlines()
        f.close()
        #pat = np.empty([self.faces, self.pixels * self.pixels + 100])
        pat = np.empty([self.faces, self.pixels * self.pixels + 71])
        i = 0
        ages = [0] * 71
        if validate == True:
            limit = self.facesValidate
        else:
            limit = self.faces
        for line in l:
            try:
                trio = line.split(",")
                if validate:
                    print trio
                age = self.getage("../../../img/" + trio[0])
                a = self.getagecoded(age)
                ages_tmp = [sum(x) for x in zip(ages, a)]
                #print max(ages_tmp)
                if max(ages_tmp) < 16:
                  ages = [sum(x) for x in zip(ages, a)]
                  #print ages
                  v = self.rawface2vector("../../../img/" + str(trio[0]))
                  #if len(v) == self.pixels * self.pixels:
                      #pat[i] = a + v
                  #else:
                      #print "Discarded"
                  pat[i] = a + v
                  i = i + 1
                  if i >= limit:
                      break
            except Exception:
                print "Fallo"
                traceback.print_exc(file=sys.stdout)
        print ages
        print sum(ages)
        print len(ages)
        return pat[:,1:]

    def getarea(self, image):
        return image.shape[0] * image.shape[1]

    def getAgeToSegment(self, age):
        return round(float(age) / 5.0) * 5.0 - 3.0

    def regressions(self):
        f = file("train_gtregre2.csv")
        l = f.readlines()
        f.close()
        sizes = []
        i = 0
        for line in l:
            trio = line.split(",")
            image = self.getimage("../../../img/" + str(trio[0]))
            try:
              #f = self.getarea(self.getface(image))
              #b = self.getarea(self.getbody(image))
              s = self.getarea(self.getsmile(image))
              #n = self.getarea(self.getnose(image))
              #le = self.getarea(self.getlefteye(image))
              #re = self.getarea(self.getrighteye(image))
              a = str(int(float(trio[1])))
              #sizes.append(trio[0] + "," + str(b) + "," + str(f) + "," + str(s) + "," + str(n) + "," + str(le) + "," + str(re) + "," + a)
              sizes.append(trio[0] + "," + str(s) + "," + a)
              print sizes[i]
              i = i + 1
            except Exception:
                print "Fallo"
            #sizes.append(str(fa) + "," + a)
            if i >= self.faces:
                break
        return sizes

    def pca(self, X, n):
        # Principal Component Analysis
        # input: X, matrix with training data as flattened arrays in rows
        # return: projection matrix (with important dimensions first),
        # variance and mean

        #get dimensions
        num_data,dim = X.shape

        #center data
        mean_X = X.mean(axis=0)
        for i in range(num_data):
            X[i] -= mean_X

        if dim>100:
            print 'PCA - compact trick used'
            M = dot(X,X.T) #covariance matrix
            e,EV = linalg.eigh(M) #eigenvalues and eigenvectors
            tmp = dot(X.T,EV).T #this is the compact trick
            V = tmp[::-1] #reverse since last eigenvectors are the ones we want
        else:
            print 'PCA - SVD used'
            U,S,V = linalg.svd(X)
            V = V[:num_data] #only makes sense to return the first num_data

        #return the projection matrix, the variance and the mean
        return V[:, :n]



#fd = FaceDetector()
#print fd.getPat()
#sizes = fd.regressions()
#file = file("smiles.csv", "a")
#for item in sizes:
    #file.write("%s\n" % item)
#file.close()

#image = "../../../img/000138.jpg"
#pat = fd.getPat()
#V = fd.pca(pat[:,100:], 5)
#mode = V[0].reshape(fd.pixels,fd.pixels)
#print mode
#pylab.figure()
#pylab.gray()
#pylab.imshow(mode)
#pylab.show()
#time.sleep(300)
#image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#for i in range(24, 24):
    #image = "../../../img/0001" + str(i) + ".jpg"
    #image = fd.getface(image)
    #areaface = image.shape[0] * image.shape[1]
    #print image.shape[0] * image.shape[1],
    #print "  ",
    ##cv2.imshow("image", image
    ##time.sleep(1)
    #smile = fd.getsmile(image)
    #print smile.shape[0] * smile.shape[1] * 1.0 / areaface,
    #print "  ",
    ##cv2.imshow("Smile", smile)
    ##time.sleep(4)
    #eye = fd.getlefteye(image)
    #print eye.shape[0] * eye.shape[1] * 1.0 / areaface,
    #print "  ",
    ##cv2.imshow("Left eye", smile)
    ##time.sleep(4)
    #eye = fd.getrighteye(image)
    #print eye.shape[0] * eye.shape[1] * 1.0 / areaface,
    #print "  ",
    ##cv2.imshow("Right eye", smile)
    #nose = fd.getnose(image)
    #print nose.shape[0] * nose.shape[1] * 1.0 / areaface
    #cv2.imshow("Nose", nose)
    #v = fd.rawface2vector(image)
    #print v
    #print len(v)
    #time.sleep(4)
#kk = fd.getPat()
#tt = kk[1]
#print kk
#print tt
#print kk
