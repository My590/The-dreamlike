extends Control

@onready var slider = $PreferencesPanel/HSlider
@onready var value_label = $PreferencesPanel/Volume
@onready var language_option_button = $PreferencesPanel/OptionButton

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


func _on_option_button_pressed() -> void:
	language_option_button.add_item("Português")
	language_option_button.add_item("English")

	language_option_button.item_selected.connect(_on_language_selected)

	# Define qual opção aparece selecionada
	if TranslationServer.get_locale().begins_with("pt"):
		language_option_button.select(0)
	else:
		language_option_button.select(1)


func _on_language_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("pt")
	else:
		TranslationServer.set_locale("en")
