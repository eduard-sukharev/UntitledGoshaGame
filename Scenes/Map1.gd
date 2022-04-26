extends Node2D

func _ready():
	var complex_task = {
		'types': {
			'destructable': {'hp': 5},
			'processable': {'processing_time': 3}
		},
	}
	var destructable_task = {
		'types': {
			'destructable': {'hp': 5},
		},
	}
	var processable_task = {
		'types': {
			'processable': {'processing_time': 3}
		},
	}

	for spawn_area in $TaskSpawners.get_children():
		spawn_area.config(destructable_task)
		spawn_area.config(processable_task)
