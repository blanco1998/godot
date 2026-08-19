class_name GameUi
extends Control


@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_jump_label: Label = $MarginContainer/PressJumpLabel
@onready var show_second_label: Timer = $ShowSecondLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var score: Label = $MarginContainer/Score


func _ready() -> void:
	SignalHub.tappy_died.connect(_on_game_over)
	SignalHub.point_scored.connect(_on_point_scored)
	#Desactivamos procces mode para que el pause no le afecte
	#Puede hacerse con el editor o codigo
	process_mode = Node.PROCESS_MODE_ALWAYS
	_on_point_scored(0)



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		#GameManager.load_main_screen()
		ComplexChange.load_main_screen()
	
	if press_jump_label.visible && event.is_action_pressed("fly"):
		#GameManager.load_main_screen()
		ComplexChange.load_main_screen()


func _on_game_over() -> void:
	game_over_label.show()
	audio_stream_player_2d.play()
	show_second_label.start(2.5)


func _on_show_second_label_timeout() -> void:
	game_over_label.hide()
	press_jump_label.show()


func _on_point_scored(points: int) -> void:
	score.text = "%04d" % points
