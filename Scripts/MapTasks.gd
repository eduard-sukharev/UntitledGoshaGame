extends Node

func _on_SpawnArea_new_task(task):
	add_child(task)
