extends Node

signal health_changed(current, maximum)

var player_name := ""
var player_pronoun := ""
var money := 0
var beast_hp := 100
var beast_max_health := 100
var current_round := 1
var chapter := 1
var max_health := 100
var health := 100
var current_dialogue = "start"
var last_person_texted := ""
var morning_route := ""
var current_background := ""

var player_card := ""
var beast_card := ""
var player_damage := 0
var beast_damage := 0
var card_round := 1
var total_rounds := 3

var deck: Array[String] = []

func start_card_game():
	create_deck()

	health = max_health
	beast_hp = beast_max_health

	card_round = 1

	player_card = ""
	beast_card = ""
	
func is_game_over() -> bool:
	return (
		card_round > total_rounds
		or health <= 0
		or beast_hp <= 0
	)
	
func get_winner() -> String:

	if health <= 0:
		return "beast"

	if beast_hp <= 0:
		return "player"

	if health > beast_hp:
		return "player"

	if beast_hp > health:
		return "beast"

	return "draw"

func create_deck():
	deck.clear()

	# Kings (2)
	deck.append("king")
	deck.append("king")

	# Queens (2)
	deck.append("queen")
	deck.append("queen")

	# Rooks (4)
	for i in range(4):
		deck.append("rook")

	# Bishops (4)
	for i in range(4):
		deck.append("bishop")

	# Knights (4)
	for i in range(4):
		deck.append("knight")

	# Pawns (16)
	for i in range(16):
		deck.append("pawn")

	deck.shuffle()
	
func draw_card() -> String:
	if deck.is_empty():
		return ""

	return deck.pop_back()
	
func player_draw_card():
	player_card = draw_card()
	return player_card

func beast_draw_card():
	beast_card = draw_card()
	return beast_card

func get_card_value(card: String) -> int:
	match card:
		"pawn":
			return 10
		"knight":
			return 30
		"bishop":
			return 30
		"rook":
			return 50
		"queen":
			return 70
		"king":
			return 0
		_:
			return 0

func get_card_name(card: String) -> String:
	match card:
		"pawn":
			return "Pawn"
		"knight":
			return "Knight"
		"bishop":
			return "Bishop"
		"rook":
			return "Rook"
		"queen":
			return "Queen"
		"king":
			return "King"
		_:
			return "Unknown"

func use_card(card:String,  played_by:String):

	match card:

		"pawn":
			deal_damage(played_by, 10)

		"knight":
			deal_damage(played_by, 30)

		"bishop":
			deal_damage(played_by, 30)

		"rook":
			deal_damage(played_by, 50)

		"queen":
			deal_damage(played_by, 70)

		"king":
			heal(played_by, 50)
			
func deal_damage(target:String, amount:int):

	if target == "player":
		beast_hp = max(beast_hp - amount, 0)
	else:
		change_health(-amount)
		
func heal(target:String, amount:int):

	if target == "player":
		change_health(amount)

	else:
		beast_hp += amount
		beast_hp = clamp(beast_hp, 0, beast_max_health)

func resolve_round():
	use_card(player_card, "player")
	use_card(beast_card, "beast")

	card_round += 1

func change_health(amount: int):
	health += amount
	health = clamp(health, 0, max_health)

	health_changed.emit(health, max_health)

func is_dead() -> bool:
	return health <= 0

func set_dialogue(id: String):
	current_dialogue = id
	
func print_route():
	print("MORNING ROUTE = ", morning_route)
	

var subject_pronoun := ""
var object_pronoun := ""
var possessive_adjective := ""
var possessive_pronoun := ""
var reflexive_pronoun := ""
