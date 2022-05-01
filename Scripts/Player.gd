extends KinematicBody2D

class_name Player

var dir: String = 'E'
var id = 0

const RIGHT = 'player_right'
const LEFT = 'player_left'
const UP = 'player_up'
const DOWN = 'player_down'
const L1 = 'player_L1'
const R1 = 'player_R1'
const A = 'player_A'
const B = 'player_B'
const X = 'player_X'
const Y = 'player_Y'

signal got_scores(id, scores)

func is_action_pressed(action):
	return Input.is_action_pressed(str(action, '_', id))

func is_action_just_pressed(action):
	return Input.is_action_just_pressed(str(action, '_', id))

func is_action_just_released(action):
	return Input.is_action_just_released(str(action, '_', id))

func award(scores: int):
	print('Awarded: ', scores)
	emit_signal('got_scores', id, scores)

func _process(delta):
	if $Behaviors/Movable.is_moving:
		$AnimatedSprite.play('walk_' + dir)
	else:
		$AnimatedSprite.play('idle')

func _physics_process(delta):
	$Behaviors/Movable.move(self, delta)

	if is_action_pressed(RIGHT):
		dir = 'E'
	elif is_action_pressed(LEFT):
		dir = 'W'

	if dir == '':
		dir = 'E'

	# Enable grabing area only when grab button pressed
	if is_action_just_pressed(L1):
		$GrabArea/GrabShape.disabled = false
	if is_action_just_released(L1):
		$GrabArea/GrabShape.disabled = true

	if is_action_just_pressed(A):
		for grip_key in $Behaviors/Grip.gripped:
			$Behaviors/Damage.deal_damage($Behaviors/Grip.gripped[grip_key])

	if is_action_just_pressed(B):
		for grip_key in $Behaviors/Grip.gripped:
			$Behaviors/Process.start_processing($Behaviors/Grip.gripped[grip_key])
	elif is_action_just_released(B):
		for grip_key in $Behaviors/Grip.gripped:
			$Behaviors/Process.stop_processing($Behaviors/Grip.gripped[grip_key])


func _on_GrabArea_body_entered(body):
	print('grab area body entered')
	$Behaviors/Grip.grip(self, body)


func _on_GrabArea_body_exited(body):
	$Behaviors/Grip.release(self, body)
