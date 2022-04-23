extends KinematicBody2D

class_name Player

var dir: String = 'E'

func _process(delta):
	if $Behaviors/Movable.is_moving:
		$AnimatedSprite.play('walk_' + dir)
	else:
		$AnimatedSprite.play('idle')


func _physics_process(delta):
	$Behaviors/Movable.move(self, delta)

func _input(event):
	dir = ''
	if Input.is_action_pressed("ui_down"):
		dir = 'S'
	elif Input.is_action_pressed("ui_up"):
		dir = 'N'

	if Input.is_action_pressed("ui_right"):
		dir += 'E'
	elif Input.is_action_pressed("ui_left"):
		dir += 'W'

	if dir == '':
		dir = 'E'

