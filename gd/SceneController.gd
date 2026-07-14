extends Node

signal sequence_finished

var background
var fade
var character
var game: Node

func register_game(game_node: Node):
	game = game_node
	
func play_video(path: String):
	if game:
		game.play_video(path) 

func change_background(path: String):
	background.texture = load(path)
	
func show_character(path: String):
	character.texture = load(path)

func play_music(path: String):
	MusicManager.play_music(path)

func sleep_sequence() -> void:
	await fade_out()

	MusicManager.play_music("res://Visual Novel Romance/music/alarm-clock.mp3")

	await get_tree().create_timer(3).timeout

	await fade_in()

	sequence_finished.emit()

func fade_to_black():
	await fade_out()

func fade_out():
	var tween = fade.create_tween()

	tween.tween_property(
		fade,
		"modulate:a",
		1.0,
		2.0
	)

	await tween.finished


func fade_in():
	var tween = fade.create_tween()

	tween.tween_property(
		fade,
		"modulate:a",
		0.0,
		2.0
	)

	await tween.finished
