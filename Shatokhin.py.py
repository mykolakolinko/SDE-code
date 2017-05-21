#!/usr/local/bin/python3
from random import gauss
from math import *

#def SimulateProcesses(theta, definitePart, randomPart, start, stepLength, maxSteps):
def SimulateProcesses(a, b, c, d, stepLength, maxSteps, start):
	Euler = [start]
	Explicit = [start]
	addend = start
	multiplier = 1
	for i in range(maxSteps):
		increment = gauss(0, sqrt(stepLength))
		Euler += [Euler[-1] + (a * Euler[-1] + b) * stepLength + (c * Euler[-1] + d) * increment]
		addend += (b - c * d) / multiplier * stepLength + d / multiplier * increment
		multiplier *= exp((a - c ** 2 / 2) * stepLength + c * increment)
		Explicit += [addend * multiplier]
		#Euler += [Euler[-1] + theta * definitePart(Euler[-1]) * stepLength + randomPart(Euler[-1]) * increment]
	return (Euler, Explicit)
	#return Euler


#definitePart = lambda x: 1 + sin(2 * x)
#randomPart = lambda x: 1 - cos(x)
#theta = float(input("Parameter theta: "))
a = float(input("Parameter a: "))
b = float(input("Parameter b: "))
c = float(input("Parameter c: "))
d = float(input("Parameter d: "))
start = float(input("Starting value: "))
stepsPerUnit = int(input("Steps per unit length: "))
stepLength = 1 / stepsPerUnit
T = int(input("T: "))
trajCount = int(input("Number of trajectories: "))
fileName = input("Output file name: ")
maxSteps = stepsPerUnit * T

fileObject = open(fileName, "w")

for i in range(trajCount):
	Euler, Explicit = SimulateProcesses(a, b, c, d, stepLength, maxSteps, start)
	#maxVal = max([Euler[i] - Explicit[i] for i in range(len(Euler))])
	#fileObject.write("%f\n" % (maxVal))
	for j in range(len(Euler)):
		fileObject.write("%f,%f\n" % (Euler[j], Explicit[j]))

	#Euler = SimulateProcesses(theta, definitePart, randomPart, start, stepLength, maxSteps)
	#expTheta = sum([definitePart(Euler[i]) / (randomPart(Euler[i])**2) * (Euler[i+1] - Euler[i]) for i in range(len(Euler) - 1)]) / sum([(definitePart(x)/randomPart(x))**2 * stepLength for x in Euler])
	#fileObject.write("%f\n" % (expTheta))

fileObject.close()

##expSigma = sum([(X[i+1] - X[i])**2 for i in range(len(X) - 1)]) / sum([b(x)**2 /steps for x in X])