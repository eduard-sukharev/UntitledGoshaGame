extends Node

onready var map = preload("res://Scenes/Map1.tscn").instance()

onready var camera_scene = preload("res://Scenes/Camera2D.tscn")
onready var player_scene = preload("res://Scenes/Player.tscn")
onready var player_hud_scene = preload("res://Scenes/HUD.tscn")
var players = []

var game_started : bool = false

func _unhandled_input(event):
	if game_started and Input.is_action_pressed("ui_page_up"):
		add_player()
	if game_started and Input.is_action_pressed("ui_page_down"):
		remove_player()

func add_player():
	if players.size() >= 4:
		return

	var id = players.size()
	var render = $Splitscreen.add_player(id)
	var player = player_scene.instance()
	player.id = id
	var cam = camera_scene.instance()
	cam.target = player
	render.viewport.add_child(cam)

	# First player viewport owns map instance, other viewports only reference it as world
	if id == 0:
		render.viewport.add_child(map)
	else:
		render.viewport.world_2d = $Splitscreen.get_player(0).viewport.world_2d

	var player_hud = player_hud_scene.instance()
	render.add_child(player_hud)

	map.add_child(player, true)
	players.push_back(player)

func remove_player():
	if players.size() <= 1:
		return

	var id = players.size() - 1
	$Splitscreen.remove_player(id)
	var player = players.pop_back()
	map.remove_child(player)
	player.queue_free()



func _on_Menu_game_started():
	new_game()

func new_game():
	var splitscreen = load("res://organicpencil.splitscreen/splitscreen.tscn").instance()
	add_player()
	game_started = true

	add_child(splitscreen)

	get_node("Menu").hide()
