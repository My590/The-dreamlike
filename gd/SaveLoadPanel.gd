extends Control

enum Mode {
	SAVE,
	LOAD
}

var mode: Mode

@onready var title = $CanvasLayer/Panel/Title
@onready var grid = $CanvasLayer/Panel/GridContainer
@onready var close_button = $CanvasLayer/Panel/CloseButton

func _ready():
	for i in range(grid.get_child_count()):

		var button = grid.get_child(i)
		var index = i+1

		button.pressed.connect(func():
			_on_slot_pressed(index)
		)

func setup(new_mode: Mode):
	mode = new_mode

	if mode == Mode.SAVE:
		title.text = "Salvar Jogo"
	else:
		title.text = "Carregar Jogo"

	update_slots()
	_hide_balloon()

func _on_slot_pressed(slot: int):
	print("Modo:", mode, " | Slot:", slot)

	if mode == Mode.SAVE:
		print("SALVANDO")
		SaveManager.save_game(slot)
		update_slots()
		queue_free()
	else:
			print("CARREGANDO SLOT:", slot)

	var data = SaveManager.load_game(slot)

	if data.is_empty():
		print("Slot vazio")
		return

	GameData.player_name = data.get("player_name", "")
	GameData.money = data.get("money", 0)
	GameData.chapter = data.get("chapter", 1)
	GameData.current_dialogue = data.get("dialogue", "start")

	print("Diálogo salvo:", GameData.current_dialogue)

	queue_free()

	get_tree().change_scene_to_file("res://tscn/game.tscn")

func update_slots():
	for i in range(grid.get_child_count()):

		var slot = grid.get_child(i)
		var save_slot = i + 1

		slot.get_node("VBoxContainer/SlotLabel").text = "Slot %d" % save_slot

		var path = SaveManager.get_save_path(save_slot)

		if FileAccess.file_exists(path):

			var data = SaveManager.load_game(save_slot)

			slot.get_node("VBoxContainer/PlayerName").text = "Name: " + data["player_name"]
			slot.get_node("VBoxContainer/Day").text = "Chapter: " + str(data.get("chapter", 1))
			slot.get_node("VBoxContainer/Date").text = data.get("date", "No Date")

		else:

			slot.get_node("VBoxContainer/PlayerName").text = "Vazio"
			slot.get_node("VBoxContainer/Day").text = ""
			slot.get_node("VBoxContainer/Date").text = ""

func _on_close_button_pressed() -> void:
	_show_balloon()
	queue_free()
	
func _hide_balloon():
	var balloon = get_tree().root.find_child("ExampleBalloon", true, false)

	if balloon:
		balloon.hide()

func _show_balloon():
	var balloon = get_tree().root.find_child("ExampleBalloon", true, false)

	if balloon:
		balloon.show()
