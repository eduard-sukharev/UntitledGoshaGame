extends Area2D

export var team_color = 'blue'
export var spawn_delay = 0.5

var team_backlog: Array = []
var Task = preload("res://Scenes/Task.tscn")

signal new_task(task)

func _ready():

	var destructable_config = {'destructable': {'hp': 5}}
	var processable_config = {'processable': {'processing_time': 3}}
	for i in range(5):
		var task = Task.instance()
		task.configure(destructable_config)
		team_backlog.append(task)
	for i in range(3):
		var task = Task.instance()
		task.configure(processable_config)
		team_backlog.append(task)

	$Timer.wait_time = spawn_delay


func _on_Timer_timeout():
	if team_backlog.size() <= 0:
		$Timer.stop()
		return

	var task = team_backlog.pop_back()
	randomize()
	task.set_global_position(
		get_global_position()
		+ $CollisionShape2D.get_shape().extents * rand_range(-1, 1)
	)
	emit_signal('new_task', task)
