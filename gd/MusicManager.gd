extends Node

var player: AudioStreamPlayer
var music_volume_db: float = -20

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)
	player.volume_db = 0

func _on_volume_changed(value):
	MusicManager.set_music_volume(value)
	
func play_music(path: String):
	var stream: AudioStream = load(path)

	if stream == null:
		print("Áudio não encontrado:", path)
		return

	# Se a mesma música já estiver tocando, não reinicia.
	if player.playing and player.stream == stream:
		return

	player.stream = stream
	player.volume_db = music_volume_db
	player.play()
	
func play_music_for(path: String, seconds: float):
	play_music(path)

	await get_tree().create_timer(seconds).timeout

	stop_music()
	
func stop_music():
	player.stop()

func set_music_volume(percent: float):
	var linear = percent / 100.0

	if linear <= 0:
		player.volume_db = -80
	else:
		player.volume_db = linear_to_db(linear)

	music_volume_db = player.volume_db
