extends Node2D

var sprint = 0

func _ready():
	next_sprint()

func next_sprint():
	var sprint_tasks = Settings.sprints()[sprint]
	for spawn_area in $TaskSpawners.get_children():
		for task_config in sprint_tasks:
			spawn_area.configure(task_config)

	sprint += 1
