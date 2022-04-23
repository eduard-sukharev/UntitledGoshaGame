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

	# Enable grabing area only when grab button pressed
	if Input.is_action_just_pressed("ui_select"):
		$GrabArea.get_node(dir).disabled = false
	if Input.is_action_just_released("ui_select"):
		for shape in $GrabArea.get_children():
			shape.disabled = true

	if Input.is_action_pressed("ui_accept"):
		for grip_key in $Behaviors/Grip.gripped:
			$Behaviors/Damage.deal_damage($Behaviors/Grip.gripped[grip_key])


func _on_GrabArea_body_entered(body):
	$Behaviors/Grip.grip(self, body)


func _on_GrabArea_body_exited(body):
	$Behaviors/Grip.release(self, body)
