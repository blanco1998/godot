extends Node

const MAIN = preload("uid://bk7wx4bliuk8n")
const GAME = preload("uid://cmvi8rt67bmrw")
const LOADING_SCREEN = preload("uid://cicvk2qobsf8p")


#region Original
#func load_game_screen() -> void:
	#get_tree().change_scene_to_packed(GAME)
#
#func load_main_screen() -> void:
	#get_tree().change_scene_to_packed(MAIN)
#endregion

#region Simple
var _next_scene: PackedScene

func change_to_next() -> void:
	get_tree().change_scene_to_packed(_next_scene)

func load_game_screen() -> void:
	_next_scene = GAME
	get_tree().change_scene_to_packed(LOADING_SCREEN)

func load_main_screen() -> void:
	_next_scene = MAIN
	get_tree().change_scene_to_packed(LOADING_SCREEN)
#endregion
