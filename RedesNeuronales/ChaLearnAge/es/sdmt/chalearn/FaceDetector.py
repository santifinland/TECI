# -*- coding: utf-8 -*-

# Master TECI
# Neural Networks and Statistical Learning
# Face Detector to extract different face features from images


import cv2
import perceptron
import numpy as np
import Point
import random
from sklearn.preprocessing import scale


class FaceDetector(object):

    def __init__(self, segments=10, margin=3, elementsPerSegment=50, sobremuestreo=False,
                 fileTrain="train1.csv", fileValidate="validate1.csv", fileTest="test.csv",
                 fileProportionsNose="proportionnose.csv", fileDistancesEyeNose="distancenoseeye.csv",
                 fileDistancesMouthNose="distancemouthnose.csv"):
        self.cascPathFace = "haarcascade_frontalface_default.xml"
        self.cascPathMouth = "haarcascade_mcs_mouth.xml"
        self.cascPathSmile = "haarcascade_smile.xml"
        self.cascPathRightEye = "haarcascade_righteye_2splits.xml"
        self.cascPathLeftEye = "haarcascade_lefteye_2splits.xml"
        self.cascPathNose = "haarcascade_mcs_nose.xml"
        self.cascPathBody = "haarcascade_lowerbody.xml"
        self.cascPathRightEar = "haarcascade_mcs_rightear.xml"
        self.cascPathLeftEar = "haarcascade_mcs_leftear.xml"
        self.pixels = 50.0
        self.pixelsFace = 100.0
        self.pixelsNose = 50.0
        self.faces = 4000.0
        self.maxItems = 4000.0
        self.fileGroundTruth = "train_gt.csv"
        self.fileTrain = fileTrain
        self.fileValidate = fileValidate
        self.fileTest = fileTest
        self.fileProportionsNose = fileProportionsNose
        self.fileDistancesEyeNose = fileDistancesEyeNose
        self.fileDistancesMouthNose = fileDistancesMouthNose
        self.segments = segments
        self.margin = margin
        self.elementsPerSegment = elementsPerSegment
        self.sobremuestreo = sobremuestreo

    ''' Load image into memory '''
    def getimage(self, path):
        image = cv2.imread(path)
        return cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    '''                                                         '''
    ''' Detect and extract image objects: face, nose, eye, etc '''
    '''                                                         '''

    ''' Get and extract a given image object '''
    def getimagefeature(self, image, cascade_xml):
        cascade = cv2.CascadeClassifier(cascade_xml)
        features = cascade.detectMultiScale(
            image,
            scaleFactor=1.1,
            minNeighbors=5,
            minSize=(3, 3),
            flags = cv2.CASCADE_SCALE_IMAGE)
        area = 0
        cut_image = image
        for (x, y, w, h) in features:
            current_area = w * h
            if (current_area > area):
                area = current_area
                m = max(h, w)
                cut_image = image[y:y+m, x:x+m]
        return cut_image

    ''' Extract mouth from image '''
    def getmouth(self, path):
        return self.getimagefeature(path, self.cascPathMouth)

    ''' Extract body from image '''
    def getbody(self, path):
        return self.getimagefeature(path, self.cascPathBody)

    ''' Extract mouth from image '''
    def getsmile(self, path):
        return self.getimagefeature(self.getface(path), self.cascPathSmile)

    ''' Extract left eye from image '''
    def getlefteye(self, path):
        return self.getimagefeature(path, self.cascPathLeftEye)

    ''' Extract right eye from image '''
    def getrighteye(self, image):
        return self.getimagefeature(image, self.cascPathRightEye)

    ''' Extract nose from image '''
    def getnose(self, image):
        return self.getimagefeature(image, self.cascPathNose)

    ''' Extract left ear from image '''
    def getleftear(self, image):
        return self.getimagefeature(image, self.cascPathLeftEar)

    ''' Extract right ear from image '''
    def getrightear(self, image):
        return self.getimagefeature(image, self.cascPathRightEar)

    ''' Extract face from image '''
    def getface(self, image):
        return self.getimagefeature(image, self.cascPathFace)

    ''' Write files with the extracted face from all images '''
    def writeFaces(self):
        l = self.readfile("train_gt.csv")
        i = 0
        for line in l:
            trio = line.split(",")
            image = self.getimage("../../../img/" + str(trio[0]))
            try:
                print i
                f = self.getface(image)
                cv2.imwrite("../../../img/face/" + str(trio[0]), f)
                i = i + 1
            except Exception:
                print "Fallo"
            if i >= self.faces:
                break

    ''' Write files with the extracted and resized face from all images '''
    def writeResizedFaces(self):
        l = self.readfile("train_gt.csv")
        for line in l:
            trio = line.split(",")
            try:
                image = self.getimage("../../../img/face/" + str(trio[0]))
                print trio
                f = self.getface(image)
                rf = self.resize(f, self.pixelsFace)
                cv2.imwrite("../../../img/resizedface2/" + str(trio[0]), rf)
            except Exception:
                print "Fallo"

    ''' Write files with the extracted adn resized nose from all images '''
    def writeResizedNoses(self):
        l = self.readfile("train_gt.csv")
        for line in l:
            trio = line.split(",")
            try:
                image = self.getimage("../../../img/nose/" + str(trio[0]))
                print trio
                n = self.getface(image)
                rn = self.resize(n, self.pixelsNose)
                cv2.imwrite("../../../img/resizednose/" + str(trio[0]), rn)
            except Exception:
                print "Fallo"

    ''' Write files with the extracted nose from all images '''
    def writeNoses(self):
        f = file("train_gt.csv")
        l = f.readlines()
        f.close()
        for line in l:
            trio = line.split(",")
            print(trio)
            try:
                image = self.getimage("../../../img/face/" + str(trio[0]))
                n = self.getnose(image)
                cv2.imwrite("../../../img/nose/" + str(trio[0]), n)
            except Exception:
                print "Fallo"

    ''' Write single file with the proportion of nose compared to whole face area for each image '''
    def writeProportionNose(self):
        l = self.readfile("train_gt.csv")
        fd = file("proportionnose.csv", "a")
        for line in l:
            trio = line.split(",")
            try:
                image = self.getimage("../../../img/face/" + str(trio[0]))
                area = self.getarea(image)
                f = self.getface(image)
                fa = self.getarea(f)
                n = self.getarea(self.getnose(f))
                fd.write(str(trio[0]) + "," + str(int(float(trio[1]))) + "," + str(area) + "," + str(fa) + "," +
                         str(n) + "\n")
            except Exception:
                print "Fallo"
        fd.close()

    ''' Write single file with the distance of nose to eyes for each image '''
    def writeDistanceNoseEyes(self):
        l = self.readfile("train_gt.csv")
        fd = file("distancenoseeye.csv", "a")
        for line in l:
            trio = line.split(",")
            try:
                image = self.getimage("../../../img/face/" + str(trio[0]))
                len = self.getnoselefteyedistance(image)
                ren = self.getnoserighteyedistance(image)
                fd.write(str(trio[0]) + "," + str(int(float(trio[1]))) + "," + str(len) + "," + str(ren) + "\n")
            except Exception:
                print "Fallo"
        fd.close()

    ''' Write single file with the distance of nose to mouth for each image '''
    def writeDistanceMouthNose(self):
        l = self.readfile("train_gt.csv")
        fd = file("distancemouthnose.csv", "a")
        for line in l:
            trio = line.split(",")
            try:
                image = self.getimage("../../../img/face/" + str(trio[0]))
                d = self.getmouthnosedistance(image)
                fd.write(str(trio[0]) + "," + str(int(float(trio[1]))) + "," + str(d) + "\n")
            except Exception:
                print "Fallo"
        fd.close()

    '''                                                         '''
    ''' Get different features from an image: center, area, etc '''
    '''                                                         '''

    ''' Extract center of an object from image '''
    def getfeaturecenter(self, image, cascade_xml):
        cascade = cv2.CascadeClassifier(cascade_xml)
        features = cascade.detectMultiScale(
            image,
            scaleFactor=1.1,
            minNeighbors=5,
            minSize=(3, 3),
            flags = cv2.CASCADE_SCALE_IMAGE)
        area = 0
        p = Point.Point(0, 0)
        for (x, y, w, h) in features:
            current_area = w * h
            if current_area > area:
                area = current_area
                m = max(h, w)
                p.X = x + m / 2
                p.Y = y + m / 2
        return p

    ''' Get distance from left eye to nose of the face in an image '''
    def getnoselefteyedistance(self, image):
        centernose = self.getfeaturecenter(image, self.cascPathNose)
        centerlefteye = self.getfeaturecenter(image, self.cascPathLeftEye)
        distancelefteye = centernose.distance(centerlefteye)
        area = self.getarea(self.getface(image))
        return distancelefteye / area

    ''' Get distance from right eye to nose of the face in an image '''
    def getnoserighteyedistance(self, image):
        centernose = self.getfeaturecenter(image, self.cascPathNose)
        centerrighteye = self.getfeaturecenter(image, self.cascPathRightEye)
        distancerighteye = centernose.distance(centerrighteye)
        area = self.getarea(self.getface(image))
        return distancerighteye / area

    ''' Get distance from mouth to nose of the face in an image '''
    def getmouthnosedistance(self, image):
        centernose = self.getfeaturecenter(image, self.cascPathNose)
        centermouth = self.getfeaturecenter(image, self.cascPathSmile)
        distance = centernose.distance(centermouth)
        area = self.getarea(self.getface(image))
        return distance / area

    ''' Get vector of proportions of objects from an image  '''
    def getVectorOfProportions(self, image):
        l = self.readfile(self.fileProportionsNose)
        n = 0
        for line in l:
            proportions = line.split(",")
            if (proportions[0] == image):
                if ((float(proportions[2]) == float(proportions[3])) | (float(proportions[4]) / float(proportions[3]) > 0.3)):
                    n = 0.1
                else:
                    n = float(proportions[4]) / float(proportions[3])
        l = self.readfile(self.fileDistancesEyeNose)
        den = 0
        for line in l:
            proportions = line.split(",")
            if (proportions[0] == image):
                if ((float(proportions[2]) == 0.0) | (float(proportions[3]) == 0.0)):
                    den = 0.0045
                else:
                    den = (float(proportions[2]) + float(proportions[3])) / 2
        l = self.readfile(self.fileDistancesMouthNose)
        dmn = 0
        for line in l:
            proportions = line.split(",")
            if (proportions[0] == image):
                if ((float(proportions[2]) == 0.0) | (float(proportions[2]) > 0.03)):
                    dmn = 0.0025
                else:
                    dmn = float(proportions[2])

        vector = [n, den, dmn]
        return vector

    '''                                                                  '''
    ''' Manipulate images and other utils: resize, get raw vector, etc   '''
    '''                                                                  '''

    ''' Resize an image '''
    def resize(self, image, size):
        return cv2.resize(image, (int(size), int(size)), interpolation=cv2.INTER_AREA)

    def getarea(self, image):
        return image.shape[0] * image.shape[1]

    ''' Get raw vector of pixels from an image '''
    def rawimage2vector(self, path):
        image = self.getimage(path)
        image = self.image2vector(image)
        vector = image
        return vector

    ''' Get raw vector of pixels from an image '''
    def image2vector(self, image):
        return [x for x in image.flatten()]

    ''' Read all lines of a file '''
    def readfile(self, path):
        f = file(path)
        l = f.readlines()
        f.close()
        return l

    '''                                     '''
    ''' Functions related with age handling '''
    '''                                     '''

    ''' Get age from a ground truth file '''
    def getage(self, path, gtfile):
        image = path[-10:]
        l = self.readfile(gtfile)
        age = 0.0
        for line in l:
            trio = line.split(",")
            if (trio[0] == image):
                age = trio[1]
        if int(round(float(age))) > int(69):
            age = 70
        return age

    ''' Get age coded from as a vector: binary indicator of a group '''
    def getagecodedToSegment(self, age, segments):
        p = [0] * (int(segments) + 1 - self.margin)
        a = self.getAgeToSegment(age, segments)
        p[int(round(float(a)))] = 1
        return p

    ''' Get age in segments coded as a vector: binary indicator of a group '''
    def getAgeToSegment(self, age, segments):
        return round(float(age) / int((100.0 / segments)))

    def getagefromarray(self, a):
        return [i for i, j in enumerate(a) if j == max(a)][0]

    def getDataFromAge(self, data, age):
        y = data[:,0:self.segments - self.margin]
        ages = map(lambda a: self.getagefromarray(a), y)
        selected = [i for i,x in enumerate(ages) if x == age]
        return data[random.choice(selected), ]

    '''                                                          '''
    ''' Get matrix of data to train or validate a neural network '''
    '''                                                          '''
    def getData(self, face=False, nose=False, proportions=False, validate=False):

        # Read lines from train or validation file
        path = self.fileTrain
        if validate:
            path = self.fileValidate
        lines = self.readfile(path)

        # Prepare empty matrix for storing extracted features
        if proportions:
            pat = np.empty([self.maxItems, 3 + self.segments + 1 - self.margin])
        else:
            if face:
                pat = np.empty([self.maxItems, self.pixelsFace * self.pixelsFace + self.segments + 1 - self.margin])
            else:
                pat = np.empty([self.maxItems, self.pixelsNose * self.pixelsNose + self.segments + 1 - self.margin])

        # Prepare empty array for storing ages
        ages = [0] * (self.segments + 1 - self.margin)

        # Counter to keep track of items in each group
        i = 0

        # Read data
        for line in lines:
            try:

                # Get name of the image
                trio = line.split(",")

                # Get the tagged age of the image
                age = self.getage("../../../img/" + trio[0], self.fileGroundTruth)
                if validate:
                    age = self.getage("../../../img/" + trio[0], self.fileValidate)

                # Code the age in a binary array
                a = self.getagecodedToSegment(age, self.segments)

                if ages[int(round(float(self.getAgeToSegment(age, self.segments))))] < self.elementsPerSegment:
                    vface = self.rawimage2vector("../../../img/resizedface/" + str(trio[0]))
                    vnose = self.rawimage2vector("../../../img/resizednose/" + str(trio[0]))
                    vproportions = self.getVectorOfProportions(str(trio[0]))
                    ages = [sum(x) for x in zip(ages, a)]
                    if face and nose:
                        pat[i] = a + vface + vnose
                    elif face:
                        pat[i] = a + vface
                    elif proportions:
                        pat[i] = a + vproportions
                    else:
                        pat[i] = a + vnose
                    i = i + 1
            except Exception:
                continue
        if (not validate) & (self.sobremuestreo):
            (pat, i, ages) = self.fillWithSameData(pat, ages, i)
        pat = pat[:][:i]
        return pat[:,1:]

    def fillWithSameData(self, data, ages, i):
        for age in range(1,self.segments):
            try:
                diff =  ages[int(round(float(self.getAgeToSegment(age, self.segments))))] - self.elementsPerSegment
                if diff < 0:
                    for j in range(-diff):
                        data[i] = self.getDataFromAge(data, age)
                        a = self.getagecodedToSegment(age, self.segments)
                        ages = [sum(x) for x in zip(ages, a)]
                        i = i + 1
                else:
                    continue
            except Exception:
                continue
        return (data, i, ages)


def run():

    """
    Load patterns for training or validation
    """
    def load_data(validate=False):

        # Get pattern: age and  proportions or nose pixels or face pixels
        pat = fd.getData(face=face, nose=nose, proportions=proportions, validate=validate)

        # Get tagged age in vector format
        y = pat[:,0:fd.segments - fd.margin]

        # Get data: proportions or nose pixels or face pixels
        data = pat[:,fd.segments - fd.margin:]

        # Scale the data
        data = scale(data)

        # Populate a tuple list to be returned with the data
        out = []
        for i in range(data.shape[0]):
            out.append(list((data[i,:].tolist(), y[i].tolist())))

        return out

    # Selector for model: proportions, nose or face based
    proportions = True
    face = False
    nose = False

    # Instantiate FaceDetector class
    fd = FaceDetector()

    # Set neural network dimensions
    if proportions:
        input_layer_length = 3
        hidden_layer_length = 200
    else:
        if face:
            input_layer_length = fd.pixelsFace * fd.pixelsFace
            hidden_layer_length = fd.pixelsFace * fd.pixelsFace
        else:
            input_layer_length = fd.pixelsNose * fd.pixelsNose
            hidden_layer_length = fd.pixelsNose * fd.pixelsNose

    # Instantiate neural network with selected parameters
    nn = perceptron.MultilayerPerceptron(input_layer_length,
                              hidden_layer_length,
                              fd.segments - fd.margin,
                              iterations=50,
                              learning_rate=0.005,
                              momentum=0.001,
                              rate_decay=0.0001)

    # Train neural network and validate against train data
    x = load_data()
    nn.fit(x)
    nn.test(x)

    # Validate against validation data
    v = load_data(True)
    print "Test validation"
    nn.test(v)

if __name__ == '__main__':
    run()
