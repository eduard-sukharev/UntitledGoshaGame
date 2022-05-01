extends Control

class_name HUD

func show_time(total_seconds):
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60

	$MarginContainer/Panel/Time.text = '%d:%d' % [minutes, seconds]
