extends Control


@onready var score: Label = $MarginContainer/Score


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		#GameManager.load_game_screen()
		ComplexChange.load_game_screen()

func _ready() -> void:
	get_tree().paused = false
	score.text = "%04d" % ScoreManager._high_score
