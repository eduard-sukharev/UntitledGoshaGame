extends Area2D


var dir: String = 'E'

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
		get_node(dir).disabled = false
	if Input.is_action_just_released("ui_select"):
		for shape in get_children():
			shape.disabled = true
