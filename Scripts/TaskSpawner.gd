extends Node2D

export var spawn_delay = 0.5
export var spawn_area: Vector2

var team_backlog: Array = []
var Task = load("res://Scenes/Task.tscn")

signal new_task(task)

func _ready():
	var destructable_config = {'types': {'destructable': {'hp': 5}}}
	var processable_config = {'types': {'processable': {'processing_time': 3}}}
	for i in range(5):
		team_backlog.append(destructable_config)
	for i in range(3):
		team_backlog.append(processable_config)

	$Timer.wait_time = spawn_delay
	spawn_area = $CollisionShape2D.get_shape().extents

func set_spawn_area_extents(extents: Vector2):
	spawn_area = extents
	$CollisionShape2D.get_shape().extents = extents


func _on_Timer_timeout():
	if team_backlog.size() <= 0:
		$Timer.stop()
		return

	_spawn_task(team_backlog.pop_back())

func _spawn_task(config):
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


#func generate_technical_debt():
#	if tech_debt_types.size() == 0:
#		return
#
#	var tech_debt_config = tech_debt_types.keys()[randi() % tech_debt_types.size()]
#	var tech_debt: TechnicalDebt = load("res://Scenes/TechnicalDebt.tscn").instance()
#	tech_debt.configure(tech_debt_config)
