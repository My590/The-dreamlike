extends Node

signal health_changed(current, maximum)

var player_name := ""
var player_pronoun := ""
var money := 0
var chapter := 1
var max_health := 100
var health := 100
var current_dialogue = "start"
var last_person_texted := ""
var morning_route := ""

func change_health(amount: int):
	health += amount
	health = clamp(health, 0, max_health)

	health_changed.emit(health, max_health)

	if health <= 0:
		SceneController.game_over()

func is_dead() -> bool:
	return health <= 0

func set_dialogue(id: String):
	current_dialogue = id

var subject_pronoun := ""
var object_pronoun := ""
var possessive_adjective := ""
var possessive_pronoun := ""
var reflexive_pronoun := ""
