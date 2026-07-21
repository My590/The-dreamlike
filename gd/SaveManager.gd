extends Node

signal notification_requested(text)


func get_save_path(slot: int) -> String:
	return "user://save%d.save" % slot


func set_checkpoint(checkpoint: String):
	GameData.current_dialogue = checkpoint
	print("Checkpoint: ", checkpoint)


func save_game(slot: int):
	var data = {
		"player_name": GameData.player_name,
		"money": GameData.money,
		"chapter": GameData.chapter,
		"morning_route": GameData.morning_route,
		"dialogue": GameData.current_dialogue,
		"current_background": GameData.current_background,
		"date": get_save_date()
	}

	var file = FileAccess.open(get_save_path(slot), FileAccess.WRITE)

	if file == null:
		print("Erro ao abrir arquivo de save")
		return

	file.store_var(data)
	file.close()

	print("SALVANDO SLOT: ", slot)
	print("Morning Route salva: ", GameData.morning_route)
	print("Jogo salvo!")

	notification_requested.emit("Jogo salvo!")


func get_save_date() -> String:
	var time = Time.get_datetime_dict_from_system()

	return "%02d/%02d/%04d - %02d:%02d" % [
		time.day,
		time.month,
		time.year,
		time.hour,
		time.minute
	]


func load_game(slot: int) -> Dictionary:
	if not FileAccess.file_exists(get_save_path(slot)):
		print("Nenhum save encontrado.")
		return {}

	var file = FileAccess.open(get_save_path(slot), FileAccess.READ)

	if file == null:
		push_error("Não foi possível abrir o save.")
		return {}

	var data = file.get_var()
	file.close()

	GameData.player_name = data.get("player_name", "")
	GameData.money = data.get("money", 0)
	GameData.chapter = data.get("chapter", 1)
	GameData.morning_route = data.get("morning_route", "")
	GameData.current_dialogue = data.get("dialogue", "")
	GameData.current_background = data.get("current_background", "")

	print("Jogo carregado no slot: ", slot)
	print("Morning Route carregada: ", GameData.morning_route)

	return data

func read_save(slot: int) -> Dictionary:
	if not FileAccess.file_exists(get_save_path(slot)):
		return {}

	var file = FileAccess.open(get_save_path(slot), FileAccess.READ)

	if file == null:
		return {}

	var data = file.get_var()
	file.close()

	return data
