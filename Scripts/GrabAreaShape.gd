extends Area2D

func _input(event):
	# Enable grabing area only when grab button pressed
	if Input.is_action_just_pressed("ui_select"):
		get_node(get_parent().dir).disabled = false
	if Input.is_action_just_released("ui_select"):
		for shape in get_children():
			shape.disabled = true
