extends Node

func sprints() -> Array:
	var destructable_td_config = {
		'types': {
			'destructable': {'hp': 3},
		},
		'scale': 0.7,
		'cost': 15
	}
	var processable_td_config = {
		'types': {
			'processable': {'processing_time': 1}
		},
		'scale': 0.6,
		'cost': 10
	}

	var mixed_task = {
		'types': {
			'destructable': {'hp': 10},
			'processable': {'processing_time': 5}
		},
		'tech_debt': processable_td_config,
		'tech_debt_limit': 3, # technically not possible to generate TD in mixed tasks, yet
		'cost': 100
	}
	var destructable_task = {
		'types': {
			'destructable': {'hp': 5},
		},
		'tech_debt': processable_td_config,
		'tech_debt_limit': 3,
		'cost': 70
	}
	var processable_task = {
		'types': {
			'processable': {'processing_time': 3}
		},
		'tech_debt': destructable_td_config,
		'tech_debt_limit': 2,
		'cost': 40
	}

	return [
		[
			processable_task,
			destructable_task,
			processable_task,
			destructable_task,
			mixed_task,
			destructable_task,
			mixed_task,
			mixed_task,
			destructable_task,
		],
	]
