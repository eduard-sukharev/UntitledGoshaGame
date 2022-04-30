extends Control

class_name MainMenu

signal game_started()

func _ready():
	load_random_gosha()

func _on_StartButton_pressed():
	emit_signal('game_started')

func load_random_gosha():
	randomize()
	var rand_id = randi() % 18
	$TextureRect.texture = load("res://Assets/HUD/GoshaRandom/gosha_" + str(rand_id) + ".png")


func _on_Menu_hide():
	load_random_gosha()
