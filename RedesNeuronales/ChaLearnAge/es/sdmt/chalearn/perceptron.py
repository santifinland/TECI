# -*- coding: utf-8 -*-

# Master TECI
# Neural Networks and Statistical Learning
# Multilayer Perceptron
# Inspired in https://github.com/FlorianMuellerklein/Machine-Learning


import numpy as np
import random


class MultilayerPerceptron(object):

    def __init__(self, input, hidden, output, iterations=20, learning_rate=0.01,
                 hl_in=0, hl_out=0, momentum=0.0, rate_decay=0.0, verbose=False):
        """
        :param input: number of input neurons
        :param hidden: number of hidden neurons
        :param output: number of output neurons
        :param iterations: maximum number of iterations
        :param learning_rate: initial learning rate
        :param hl_in: regularization term for hidden layer input
        :param hl_out: regularization term for hidden layer output
        :param momentum: momentum
        :param rate_decay: how much to decrease learning rate by on each iteration (epoch)
        :param verbose: shows different messages
        """
        # Initialize parameters
        self.iterations = iterations
        self.learning_rate = learning_rate
        self.l2_in = hl_in
        self.l2_out = hl_out
        self.momentum = momentum
        self.rate_decay = rate_decay
        self.verbose = verbose

        # Initialize neural network layers
        self.input = input + 1
        self.hidden = hidden
        self.output = output

        # Set up array of 1s for activations
        self.ai = np.ones(self.input)
        self.ah = np.ones(self.hidden)
        self.ao = np.ones(self.output)

        # Create randomized weights
        # Use scheme from efficient Backpropagation by LeCun 1998 to initialize weights for hidden layer
        input_range = 1.0 / self.input ** (1/2)
        self.wi = np.random.normal(loc = 0, scale = input_range, size = (self.input, self.hidden))
        self.wo = np.random.uniform(size = (self.hidden, self.output)) / np.sqrt(self.hidden)

        # create arrays of 0 for changes
        # this is essentially an array of temporary values that gets updated at each iteration
        # based on how much the weights need to change in the following iteration
        self.ci = np.zeros((self.input, self.hidden))
        self.co = np.zeros((self.hidden, self.output))

        self.error_edad = 0

    # transfer functions
    def sigmoid(self, x):
        return 1 / (1 + np.exp(-x))

    # derivative of sigmoid
    def dsigmoid(self, y):
        return y * (1.0 - y)

    # using tanh over logistic sigmoid for the hidden layer is recommended
    def tanh(self, x):
        return np.tanh(x)

    # derivative for tanh sigmoid
    def dtanh(self, y):
         return 1 - y * y

    def feedForward(self, inputs):
        """
        The feedforward algorithm loops over all the nodes in the hidden layer and
        adds together all the outputs from the input layer * their weights
        the output of each node is the sigmoid function of the sum of all inputs
        which is then passed on to the next layer.
        :param inputs: input data
        :return: updated activation output vector
        """
        if len(inputs) != self.input-1:
            raise ValueError('Wrong number of inputs!')

        # input activations
        self.ai[0:self.input -1] = inputs

        # hidden activations
        sum = np.dot(self.wi.T, self.ai)
        self.ah = self.tanh(sum)

        # output activations
        sum = np.dot(self.wo.T, self.ah)
        self.ao = self.sigmoid(sum)

        return self.ao

    def backPropagate(self, targets):
        """
        For the output layer
        1. Calculates the difference between output value and target value
        2. Get the derivative (slope) of the sigmoid function in order to determine how much the weights need to change
        3. Update the weights for every node based on the learning rate and sig derivative
        For the hidden layer
        1. Calculate the sum of the strength of each output link multiplied by how much the target node has to change
        2. Get derivative to determine how much weights need to change
        3. Change the weights based on learning rate and derivative
        :param targets: y values
        :return: updated weights
        """
        if len(targets) != self.output:
            raise ValueError('Wrong number of targets!')

        # Calculate error terms for output
        # The delta (theta) tell you which direction to change the weights
        output_deltas = self.dsigmoid(self.ao) * -(targets - self.ao)

        # Calculate error terms for hidden
        # Delta (theta) tells you which direction to change the weights
        error = np.dot(self.wo, output_deltas)
        hidden_deltas = self.dtanh(self.ah) * error

        # Update the weights connecting hidden to output, change == partial derivative
        change = output_deltas * np.reshape(self.ah, (self.ah.shape[0], 1))
        regularization = self.l2_out * self.wo
        self.wo -= self.learning_rate * (change + regularization) + self.co * self.momentum
        self.co = change

        # Update the weights connecting input to hidden, change == partial derivative
        change = hidden_deltas * np.reshape(self.ai, (self.ai.shape[0], 1))
        regularization = self.l2_in * self.wi
        self.wi -= self.learning_rate * (change + regularization) + self.ci * self.momentum
        self.ci = change

        # calculate error
        error = sum(0.5 * (targets - self.ao)**2)

        return error

    def test(self, patterns):
        """
        Print out the targets next to the predictions.
        Calculate total error.
        """
        self.error_edad = 0
        for p in patterns:
            e = self.get_age(p[1])
            l = self.feedForward(p[0])
            c = self.get_age(l)
            self.error_edad += abs((e[0] - (sum(c) / len(c))))
        print "Total error: " + str(self.error_edad / len(patterns))

    def fit(self, patterns):
        """
        Train neural network
        """
        num_example = np.shape(patterns)[0]
        for i in range(self.iterations):
            error = 0.0
            random.shuffle(patterns)
            for p in patterns:
                inputs = p[0]
                targets = p[1]
                self.feedForward(inputs)
                error += self.backPropagate(targets)

            with open('error.txt', 'a') as errorfile:
                errorfile.write(str(error) + '\n')
                errorfile.close()

            if i % 1 == 0 and self.verbose == True:
                error = error/num_example
                print('Training error %-.5f' % error)

            # learning rate decay
            self.learning_rate *= (self.learning_rate / (self.learning_rate + (self.learning_rate * self.rate_decay)))

    def predict(self, X):
        """
        return list of predictions after training algorithm
        """
        predictions = []
        for p in X:
            predictions.append(self.feedForward(p))
        return predictions

    def get_age(self, a):
        """
        Convert age in array format to decimal format
        """
        return [i + 1 for i, j in enumerate(a) if j == max(a)]


