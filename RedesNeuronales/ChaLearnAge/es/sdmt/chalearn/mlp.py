""" 
Back-Propagation Neural Networks Written in Python.

This is a slightly different version of this http://arctrix.com/nas/python/bpnn.py
"""

import math
import random
import FaceDetector
import time

random.seed(0)

# calculate a random number where:  a <= rand < b
def rand(a, b):
    return (b-a)*random.random() + a

# Make a matrix (we could use NumPy to speed this up)
def makeMatrix(I, J, fill=0.0):
    m = []
    for i in range(I):
        m.append([fill]*J)
    return m

# our sigmoid function, tanh is a little nicer than the standard 1/(1+e^-x)
def sigmoid(x):
    return math.tanh(x)

## derivative of our sigmoid function, in terms of the output (i.e. y)
def dsigmoid(y):
    return 1.0 - y**2

class NN:
    def __init__(self, ni, nh, no):
        # number of input, hidden, and output nodes
        self.ni = ni + 1 # +1 for bias node
        self.nh = nh
        self.no = no

        # activations for nodes
        self.ai = [1.0]*self.ni
        self.ah = [1.0]*self.nh
        self.ao = [1.0]*self.no
        
        # create weights
        self.wi = makeMatrix(self.ni, self.nh)
        self.wo = makeMatrix(self.nh, self.no)
        # set them to random vaules
        for i in range(self.ni):
            for j in range(self.nh):
                self.wi[i][j] = rand(0.0, 0.2)
        for j in range(self.nh):
            for k in range(self.no):
                self.wo[j][k] = rand(0.0, 2.0)

        # last change in weights for momentum   
        self.ci = makeMatrix(self.ni, self.nh)
        self.co = makeMatrix(self.nh, self.no)

    def update(self, inputs):
        #print "==="
        #print len(inputs)
        #print self.ni-1
        #print "==="
        if len(inputs) != self.ni-1:
            raise ValueError('wrong number of inputs')

        # input activations
        for i in range(self.ni-1):
            self.ai[i] = sigmoid(inputs[i])
            #self.ai[i] = inputs[i]

        # hidden activations
        for j in range(self.nh):
            sum = 0.0
            for i in range(self.ni):
                sum = sum + self.ai[i] * self.wi[i][j]
            self.ah[j] = sigmoid(sum)

        # output activations
        for k in range(self.no):
            sum = 0.0
            for j in range(self.nh):
                sum = sum + self.ah[j] * self.wo[j][k]
            self.ao[k] = sigmoid(sum)

        return self.ao[:]


    def backPropagate(self, targets, N, M):
        #print len(targets)
        #print self.no
        if len(targets) != self.no:
            raise ValueError('wrong number of target values')

        # calculate error terms for output
        output_deltas = [0.0] * self.no
        for k in range(self.no):
            error = targets[k]-self.ao[k]
            output_deltas[k] = dsigmoid(self.ao[k]) * error

        # calculate error terms for hidden
        hidden_deltas = [0.0] * self.nh
        for j in range(self.nh):
            error = 0.0
            for k in range(self.no):
                error = error + output_deltas[k]*self.wo[j][k]
            hidden_deltas[j] = dsigmoid(self.ah[j]) * error

        # update output weights
        for j in range(self.nh):
            for k in range(self.no):
                change = output_deltas[k]*self.ah[j]
                self.wo[j][k] = self.wo[j][k] + N*change + M*self.co[j][k]
                self.co[j][k] = change
                #print N*change, M*self.co[j][k]

        # update input weights
        for i in range(self.ni):
            for j in range(self.nh):
                change = hidden_deltas[j]*self.ai[i]
                self.wi[i][j] = self.wi[i][j] + N*change + M*self.ci[i][j]
                self.ci[i][j] = change

        # calculate error
        error = 0.0
        for k in range(len(targets)):
            error = error + 0.5*(targets[k]-self.ao[k])**2
        return error


    def test(self, patterns):
        for p in patterns:
            l = self.update(p[0])
            m = max(l)
            e = [i for i, j in enumerate(l) if j == m]
            print(p[0], '->', e)

    def weights(self):
        print('Input weights:')
        for i in range(self.ni):
            print(self.wi[i])
        print()
        print('Output weights:')
        for j in range(self.nh):
            print(self.wo[j])

    def train(self, patterns, iterations=1000, N=0.5, M=0.1):
        # N: learning rate
        # M: momentum factor
        for i in range(iterations):
            error = 0.0
            for p in patterns:
                inputs = p[0]
                targets = p[1]
                self.update(inputs)
                error = error + self.backPropagate(targets, N, M)
            if i % 100 == 0:
                print('error %-.5f' % error)


def demo():
    # Teach network XOR function
    pat = [
        [[1,1], [1]],
        #[[0,1,1,0], [28]],
        #[[1,0,1,3], [34]],
        [[0,0], [0]],
        [[3,3], [10]]
    ]

    image1 = "../../../img/001031.jpg"
    image2 = "../../../img/001032.jpg"
    image3 = "../../../img/001034.jpg"
    image4 = "../../../img/001035.jpg"

    fd = FaceDetector.FaceDetector()
    v1 = fd.rawface2vector(image1)
    f = file("train_gt.csv")
    l = f.readlines()
    #pat = [
        #[fd.rawface2vector(image2), [40]],
        #[fd.rawface2vector(image1), [43]],
        #[fd.rawface2vector(image3), [37]],
        #[fd.rawface2vector(image4), [29]]
    #]
    pat = fd.getPat()
    #print pat

    # create a network with two input, two hidden, and one output nodes
    n = NN(100, 50, 100)
    # train it with some patterns
    n.train(pat)
    # test it
    n.test(pat)
    #n.weights()


if __name__ == '__main__':
    demo()
