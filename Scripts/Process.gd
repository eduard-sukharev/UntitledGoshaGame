extends Node

export var damage = 1

func start_processing(object):
	if object is Task:
		object.start_processing()

func stop_processing(object):
	if object is Task:
		object.stop_processing()
