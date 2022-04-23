extends Node

export var damage = 1

func deal_damage(object):
	if object is Task:
		object.take_damage(damage)
