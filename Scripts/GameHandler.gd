extends Node

onready var map = preload("res://Scenes/Map1.tscn").instance()

onready var camera_scene = preload("res://Scenes/Camera2D.tscn")
onready var player_scene = preload("res://Scenes/Player.tscn")
onready var player_hud_scene = preload("res://Scenes/HUD.tscn")
onready var result_screen_scene = load("res://Scenes/ResultScreen.tscn")
var players : Dictionary = {}

var game_started : bool = false

func _unhandled_input(event):
	if game_started and Input.is_action_pressed("ui_page_up"):
		add_player()
	if game_started and Input.is_action_pressed("ui_page_down"):
		remove_player()

func add_player():
	print($Splitscreen.player_count)
	if $Splitscreen.player_count >= 4:
		return

	var id = $Splitscreen.player_count
	var render = $Splitscreen.add_player(id)
	var player : Player = player_scene.instance()
	player.id = id
	var cam = camera_scene.instance()
	cam.target = player
	render.viewport.add_child(cam)

	# First player viewport owns map instance, other viewports only reference it as world
	if id == 0:
		render.viewport.add_child(map)
	else:
		render.viewport.world_2d = $Splitscreen.get_player(0).viewport.world_2d

	# add player HUD
	var player_hud: HUD = player_hud_scene.instance()
	$RoundTimer.connect("counted_down", player_hud, "show_time")
	player.connect("got_scores", self, "update_player_score")
	player_hud.show_time($RoundTimer._count)
	render.add_child(player_hud)

	# add player result screen
	var result_screen: ResultScreen = result_screen_scene.instance()
	result_screen.hide()
	render.add_child(result_screen)

	map.add_child(player, true)
	players[id] = {
		"node": player,
		"hud": player_hud,
		"result_screen": result_screen,
		"score": 0,
	}

func remove_player():
	print($Splitscreen.player_count)
	if $Splitscreen.player_count <= 1:
		return

	var id = $Splitscreen.player_count - 1
	$Splitscreen.remove_player(id)

	var player = players.get(id, {}).get('node')
	map.remove_child(player)
	player.queue_free()
	players.erase(id)

func _on_Menu_game_started():
	new_game()

func new_game():
	var splitscreen = load("res://organicpencil.splitscreen/splitscreen.tscn").instance()
	add_player()
	game_started = true
	$RoundTimer.start()

	add_child(splitscreen)

	get_node("Menu").hide()

func update_player_score(player_id, added_scores):
	var player_info = players.get(player_id)
	player_info['score'] += added_scores
	player_info['hud'].show_score(player_info['score'])

func _on_RoundTimer_time_is_out():
	game_started = false
	var sprint_complete_rate = 0.9
	for player_id in players:
		players[player_id].get('hud').hide()

		players[player_id].get('result_screen').show()
		players[player_id].get('result_screen').set_player_score(players.get(player_id, {}).get('score'))
		players[player_id].get('result_screen').set_sprint_result(sprint_complete_rate)
