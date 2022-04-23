extends Node

func grip(subject, object):
	if object is Task:
		object.grip(subject)

func release(subject, object):
	if object is Task:
		object.release(subject)
