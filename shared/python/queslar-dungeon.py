#!/home/jk/ipython/venv/bin/python
import pyautogui
import sys
import numpy as np
from random import uniform
import random
import time
from scipy import interpolate
import math

def point_dist(x1,y1,x2,y2):
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

def move_bezier(x2, y2, duration):
    cp = random.randint(3, 5)  # Number of control points. Must be at least 2.
    x1, y1 = pyautogui.position()  # Starting position

    # Distribute control points between start and destination evenly.
    x = np.linspace(x1, x2, num=cp, dtype='int')
    y = np.linspace(y1, y2, num=cp, dtype='int')

    # Randomise inner points a bit (+-RND at most).
    RND = 10
    xr = [random.randint(-RND, RND) for k in range(cp)]
    yr = [random.randint(-RND, RND) for k in range(cp)]
    xr[0] = yr[0] = xr[-1] = yr[-1] = 0
    x += xr
    y += yr

    # Approximate using Bezier spline.
    degree = 3 if cp > 3 else cp - 1  # Degree of b-spline. 3 is recommended. Must be less than number of control points.
    
    tck, u = interpolate.splprep([x, y], k=degree)
    # Move upto a certain number of points
    u = np.linspace(0, 1, num=20)
    points = interpolate.splev(u, tck)

    # Move mouse.
    timeout = duration / len(points[0]) / 500
    point_list=zip(*(i.astype(int) for i in points))
    for point in point_list:
        pyautogui.moveTo(*point)
        pyautogui.click()

# Full screen
X_DELTA = 20
Y_DELTA = 5
LEFT_X = 1193 + X_DELTA
RIGHT_X = 1263 - X_DELTA
TOP_Y = 190 + Y_DELTA
BOT_Y = 215 - Y_DELTA

# Laptop
# X_DELTA = 20
# Y_DELTA = 5
# LEFT_X = 1193 + X_DELTA
# RIGHT_X = 1263 - X_DELTA
# TOP_Y = 205 + Y_DELTA
# BOT_Y = 235 - Y_DELTA

def within_bounds(x, y):
    return LEFT_X > x and RIGHT_X < x and TOP_Y > y and BOT_Y < y


pause = 0.005
while True:
    while pause < 0.15:
        pause = np.random.normal(loc=0.05, scale=0.05)

    if np.random.rand() < 0.05:
        X = uniform(LEFT_X, RIGHT_X)
        Y = uniform(TOP_Y, BOT_Y)
        num_seconds = uniform(0.05, 0.5)
        try:
            move_bezier(X, Y, duration=num_seconds)
        except ValueError:
            pass
    
    if np.random.rand() < 0.3:
        deltaX = np.random.normal(loc=1, scale=0.05)
        deltaY = np.random.normal(loc=1, scale=0.05)
        num_seconds = uniform(0.01, 0.05)
        
        X, Y = pyautogui.position()
        if within_bounds(X + deltaX, Y + deltaY):
            pyautogui.moveRel(deltaX, deltaY, duration=num_seconds)    

    pyautogui.PAUSE = pause
    if within_bounds(*pyautogui.position()):
        pyautogui.click()