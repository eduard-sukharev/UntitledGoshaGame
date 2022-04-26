extends Node

class_name PlayerMovement

export var velocity = Vector2.ZERO
export var speed = 350
export var friction = 0.15
export var acceleration = 0.1
var is_moving: bool = false
const VELOCITY_THRESHOLD = 0.1

func move(subject: Player, delta: float):
	var input = Vector2.ZERO
	if not subject.is_action_pressed(subject.L1):
		input.x =  int(subject.is_action_pressed(subject.RIGHT)) - int(subject.is_action_pressed(subject.LEFT))
		input.y =  int(subject.is_action_pressed(subject.DOWN)) - int(subject.is_action_pressed(subject.UP))

	if input.length() > 0:
		velocity = lerp(velocity, input.normalized() * speed, acceleration)
		is_moving = true
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		is_moving = false

	if velocity.length() >= VELOCITY_THRESHOLD:
		subject.move_and_slide(velocity)

