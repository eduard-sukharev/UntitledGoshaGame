extends Node

class_name TaskMovement

export var velocity = Vector2.ZERO
export var speed = 70
export var friction = 0.1
export var acceleration = 0.3

var avoid_objects: Dictionary = {}

func move(subject: KinematicBody2D, delta: float):
	var input = Vector2.ZERO

	var subject_position: Vector2 = subject.get_global_position()
	for obj_key in avoid_objects:
		var avoid_obj = avoid_objects.get(obj_key)
		if avoid_obj:
			input += subject_position - avoid_obj.get_global_position()

	if input.length() > 0:
		velocity = lerp(velocity, input.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)

	subject.move_and_slide(velocity)

