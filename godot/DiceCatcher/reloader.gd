extends Node

# Process mode = Always (seteado en el editor, mas no por codigo)

signal reload

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		reload.emit()
