extends Node

var gripped = {}

func grip(subject, object):
	if object is Task:
		object.grip(subject)
		gripped[object.get_name()] = object

func release(subject, object):
	if object is Task:
		object.release(subject)
		gripped.erase(object.get_name())
