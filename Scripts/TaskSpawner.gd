extends Node2D

export var spawn_delay = 0.5
export var spawn_area: Vector2

var team_backlog: Array = []
var Task = load("res://Scenes/Task.tscn")

signal new_task(task)

func _ready():
	spawn_area = $CollisionShape2D.get_shape().extents

func config(config: Dictionary):
	for type in config.get('types', {}):
		for i in range(3):
			team_backlog.append(config)

	if $Timer.is_stopped():
		$Timer.start(spawn_delay)

func set_spawn_area_extents(extents: Vector2):
	spawn_area = extents
	$CollisionShape2D.get_shape().extents = extents


func _on_Timer_timeout():
	if team_backlog.size() <= 0:
		$Timer.stop()
		return

	generate_task(team_backlog.pop_back())


func generate_task(config):
	var task = Task.instance()
	task.configure(config)

	randomize()
	task.set_global_position(
		get_global_position()
		+ Vector2(
			spawn_area.x * rand_range(-1, 1),
			spawn_area.y * rand_range(-1, 1)
		)
	)
	emit_signal('new_task', task)
