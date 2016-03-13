import math


class Point:

    def __init__(self, x, y):
        '''Defines x and y variables'''
        self.X = x
        self.Y = y

    def distance(self, other):
        dx = self.X - other.X
        dy = self.Y - other.Y
        return math.sqrt(dx**2 + dy**2)

