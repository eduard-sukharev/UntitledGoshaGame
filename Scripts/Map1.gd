extends Node2D

func _ready():
	var complex_task = {
		'types': {
			'destructable': {'hp': 5},
			'processable': {'processing_time': 3}
		},
		'tech_debt': {
			'types': {
				'destructable': {'hp': 3},
			},
			'scale': 0.7
		},
		'tech_debt_limit': 3,
		'cost': 30
	}
	var destructable_task = {
		'types': {
			'destructable': {'hp': 5},
		},
		'tech_debt': {
			'types': {
				'destructable': {'hp': 3},
			},
			'scale': 0.7
		},
		'tech_debt_limit': 3,
		'cost': 50
	}
	var processable_task = {
		'types': {
			'processable': {'processing_time': 3}
		},
		'tech_debt': {
			'types': {
				'destructable': {'hp': 3},
			},
			'scale': 0.7
		},
		'tech_debt_limit': 2,
		'cost': 30
	}

	for spawn_area in $TaskSpawners.get_children():
		for i in range(2):
			spawn_area.configure(destructable_task)
			spawn_area.configure(processable_task)
			spawn_area.configure(complex_task)
