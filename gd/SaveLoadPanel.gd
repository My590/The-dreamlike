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
		var index = i + 1

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
	print("Modo: ", mode, " | Slot: ", slot)

	if mode == Mode.SAVE:

		print("SALVANDO SLOT: ", slot)
		print("Morning Route antes de salvar: ", GameData.morning_route)

		SaveManager.save_game(slot)

		print("Morning Route depois de salvar: ", GameData.morning_route)

		update_slots()
		queue_free()

		return


	if mode == Mode.LOAD:

		print("CARREGANDO SLOT: ", slot)

		var data = SaveManager.load_game(slot)

		if data.is_empty():
			print("Slot vazio")
			return

		print("Diálogo salvo: ", GameData.current_dialogue)
		print("Morning Route carregada: ", GameData.morning_route)

		queue_free()

		get_tree().change_scene_to_file(
			"res://Visual Novel Romance/tscn/game.tscn"
		)


func update_slots():

	for i in range(grid.get_child_count()):

		var slot = grid.get_child(i)
		var save_slot = i + 1

		slot.get_node("VBoxContainer/SlotLabel").text = \
			"Slot %d" % save_slot

		var path = SaveManager.get_save_path(save_slot)

		if FileAccess.file_exists(path):

			# IMPORTANTE:
			# read_save apenas lê os dados
			# e não altera o GameData
			var data = SaveManager.read_save(save_slot)

			slot.get_node("VBoxContainer/PlayerName").text = \
				"Name: " + data.get("player_name", "")

			slot.get_node("VBoxContainer/Day").text = \
				"Chapter: " + str(data.get("chapter", 1))

			slot.get_node("VBoxContainer/Date").text = \
				data.get("date", "No Date")

		else:

			slot.get_node("VBoxContainer/PlayerName").text = "Vazio"
			slot.get_node("VBoxContainer/Day").text = ""
			slot.get_node("VBoxContainer/Date").text = ""


func _on_close_button_pressed() -> void:
	_show_balloon()
	queue_free()


func _hide_balloon():
	var balloon = get_tree().root.find_child(
		"ExampleBalloon",
		true,
		false
	)

	if balloon:
		balloon.hide()


func _show_balloon():
	var balloon = get_tree().root.find_child(
		"ExampleBalloon",
		true,
		false
	)

	if balloon:
		balloon.show()
