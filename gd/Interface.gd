extends Control

@onready var slider = $PreferencesPanel/HSlider
@onready var value_label = $PreferencesPanel/Volume

func _ready():
	$PreferencesPanel/HSlider.value = MusicManager.music_volume_db
	$PreferencesPanel/HSlider.value_changed.connect(_on_volume_changed)
	value_label.text = str(int(slider.value))
	
	MusicManager.play_music("res://Visual Novel Romance/music/music2.mp3")
	
func _on_volume_changed(value):
	value_label.text = str(int(value))
	MusicManager.set_music_volume(value)

func _on_about_pressed() -> void:
	$AboutPanel.show()
	$PreferencesPanel.hide()
	
func _on_preferences_pressed() -> void:
	$PreferencesPanel.show()
	$AboutPanel.hide()
	
func close_all_panels():
	$AboutPanel.hide()
	$PreferencesPanel.hide()
	
const SAVE_LOAD_PANEL = preload("res://Visual Novel Romance/tscn/SaveLoadPanel.tscn")	
	
func _on_load_pressed() -> void:
	var panel = SAVE_LOAD_PANEL.instantiate()
	add_child(panel)
	panel.setup(panel.Mode.LOAD)
	close_all_panels()

func _on_close_button_pressed():
	$AboutPanel.hide()
	$PreferencesPanel.hide()
	
func _on_quit_pressed():
	get_tree().quit()
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Visual Novel Romance/tscn/intro.tscn")
