extends Area2D

export var team_color = 'blue'
export var spawn_delay = 0.5

var team_backlog: Array = []
var task = preload("res://Scenes/Task.tscn")

signal new_task(task)

func _ready():
	team_backlog.append(task.instance())
	team_backlog.append(task.instance())
	team_backlog.append(task.instance())
	team_backlog.append(task.instance())
	team_backlog.append(task.instance())
	$Timer.wait_time = spawn_delay


func _on_Timer_timeout():
	if team_backlog.size() <= 0:
		$Timer.stop()
		return

	var task: Task = team_backlog.pop_back()
	randomize()
	task.set_global_position(
		get_global_position()
		+ $CollisionShape2D.get_shape().extents * rand_range(-1, 1)
	)
	emit_signal('new_task', task)
