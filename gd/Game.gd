extends Control

@onready var fade = $ColorRect
@onready var character_sprite = $Sprite1
@onready var video = $VideoStreamPlayer
@onready var health_label = $Panel/HealthLabel

var notification_scene = preload("res://Visual Novel Romance/tscn/notification.tscn")

func _ready():
	GameData.health_changed.connect(update_health)
	update_health(GameData.health, GameData.max_health)
	
	SceneController.register_game(self)
	SceneController.background = $TextureRect
	SceneController.fade = $ColorRect
	
	$Sprite1.visible = false
	$Sprite2.visible = false
	$Sprite3.visible = false
	$Sprite4.visible = false
	$Sprite5.visible = false
	$Sprite6.visible = false
	
	if GameData.current_background != "":
		SceneController.change_background(GameData.current_background)
	
	_start_intro()
	SaveManager.notification_requested.connect(show_notification)

	var dialogo = load("res://Visual Novel Romance/scene1.dialogue")
	var balloon = load("res://Visual Novel Romance/tscn/DialogoConfig.tscn")
	
	if GameData.current_dialogue == "":
		GameData.current_dialogue = "start"

	MusicManager.play_music("res://Visual Novel Romance/music/music1.ogg")

	DialogueManager.show_dialogue_balloon_scene(
		balloon,
		dialogo,
		GameData.current_dialogue
	)

func update_health(current, maximum):
	health_label.text = "HP: %d/%d" % [current, maximum]

func play_video(path: String):
	video.stream = load(path)
	video.scale = Vector2(0.5, 0.6)
	video.position = Vector2(300, 100)
	video.visible = true
	video.play()
	
func stop_video():
	video.stop()
	video.visible = false
	
@onready var img = $img1

func show_img(path: String):
	img.texture = load(path)
	img.visible = true

func hide_img():
	img.visible = false
	
func _on_video_stream_player_finished():
	video.stop()
	video.hide()
	
	SceneController.change_background("res://Visual Novel Romance/files/img2.png")

func change_expression(expression):
	match expression:
		"happy":
			character_sprite.texture = load("res://sprites/happy.png")
		"normal":
			character_sprite.texture = load("res://sprites/normal.png")
		"sleepy":
			character_sprite.texture = load("res://sprites/sleepy.png")
			
func _start_intro():
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, 2.0)
	await tween.finished

func _on_quit_pressed() -> void:
	get_tree().quit()

func show_notification(text):
	var notification_instance = notification_scene.instantiate()
	add_child(notification_instance)
	notification_instance.show_message(text)

func save_game():
	show_notification("Jogo salvo!")
	
const SAVE_LOAD_PANEL = preload("res://Visual Novel Romance/tscn/SaveLoadPanel.tscn")

func _on_save_pressed():
	var panel = SAVE_LOAD_PANEL.instantiate()
	add_child(panel)
	panel.setup(panel.Mode.SAVE)

func _on_load_pressed() -> void:
	var panel = SAVE_LOAD_PANEL.instantiate()
	add_child(panel)
	panel.setup(panel.Mode.LOAD)
	

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Visual Novel Romance/tscn/Interface.tscn")
