extends Control

var player_name = ""
var player_pronoun = ""

func _ready():
	$Finish.pressed.connect(_on_finish_pressed)
	MusicManager.play_music("res://Visual Novel Romance/music/music2.mp3")
	
func set_dialogue(id: String):
	GameData.current_dialogue = id

func _on_confirm_button_pressed():
	GameData.player_name = $Name.text
	GameData.player_pronoun = $Pronoun.get_item_text($Pronoun.selected)

func _on_finish_pressed():
	var name_text = $Name.text.strip_edges()

	if name_text == "":
		$Alert.text = "Type your name before continuing"
		$Alert.visible = true
		return

	GameData.player_name = name_text

	match $Pronoun.selected:
		0:
			select_she_her()
		1:
			select_he_him()
		2:
			select_other()

	GameData.current_dialogue = "start"
	get_tree().change_scene_to_file("res://Visual Novel Romance/tscn/game.tscn")

func select_she_her():
	GameData.subject_pronoun = "she"
	GameData.object_pronoun = "her"
	GameData.possessive_adjective = "her"
	GameData.possessive_pronoun = "hers"
	GameData.reflexive_pronoun = "herself"

func select_he_him():
	GameData.subject_pronoun = "he"
	GameData.object_pronoun = "him"
	GameData.possessive_adjective = "his"
	GameData.possessive_pronoun = "his"
	GameData.reflexive_pronoun = "himself"

func select_other():
	GameData.subject_pronoun = "they"
	GameData.object_pronoun = "them"
	GameData.possessive_adjective = "their"
	GameData.possessive_pronoun = "theirs"
	GameData.reflexive_pronoun = "themself"
