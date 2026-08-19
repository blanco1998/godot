extends CanvasLayer

@export var game: PackedScene
@export var main: PackedScene


@onready var animation_player: AnimationPlayer = $AnimationPlayer


var _next_scene: PackedScene

func _ready() -> void:
	#Desactivamos procces mode para que el pause no le afecte
	#Puede hacerse con el editor o codigo
	process_mode = Node.PROCESS_MODE_ALWAYS


func change_to_next() -> void:
	get_tree().change_scene_to_packed(_next_scene)

func start_transisiton(next_scene: PackedScene) -> void:
	_next_scene = next_scene
	animation_player.play("fade")
	

func load_game_screen() -> void:
	start_transisiton(game)

func load_main_screen() -> void:
	start_transisiton(main)
