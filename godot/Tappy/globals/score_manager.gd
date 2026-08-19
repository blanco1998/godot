extends Node


const SAVE_PATH: String = "user://tappy_save.dat"

var _score: int
var _high_score: int = 0


func _ready() -> void:
	SignalHub.tappy_died.connect(_on_tappy_died)
	load_to_file()


func _on_tappy_died() -> void:
	if _score > _high_score:
		_high_score = _score
		save_to_file()
	ScoreManager.score_restored()
	

func add_point() -> void:
	_score += 1
	SignalHub.emit_point_score(_score)

func score_restored() -> void:
	_score = 0



func save_to_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if !file: 
		push_error("Save: No file found.")
		return
		
	file.store_32(_high_score)


func load_to_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	if !file: 
		push_error("Load: No file found.")
		return
		
	_high_score = file.get_32()
