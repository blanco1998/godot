extends Node2D

#precarga tan pronto como el script cargue, el load carga conforme requiera
#const DICE = preload("res://scenes/dice/dice.tscn") 
const GAME_OVER: AudioStream = preload("uid://c0orcx0ncovyq")


@export var dice_scene: PackedScene #Referencia a clase Dice (v1)


@onready var score_label: Label = $ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var game_over_label: Label = $GameOverLabel


var _score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Permite reproducirse luego de pausar, puede hacerse por editor
	$Sound.process_mode = Node.PROCESS_MODE_ALWAYS
	$Reloader.reload.connect(reload)
	
	$Fox.eating_dice.connect(_on_fox_eating_dice)
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	spawn_dice()


#Hace spawn del dice en la escena padre
func spawn_dice() -> void:
	var new_dice: Dice = dice_scene.instantiate() #con packed scene
	#var new_dice: Dice = DICE.instantiate()
	add_child(new_dice)
	new_dice.off_screen.connect(_on_dice_off_screen)


# SIGNAL HANDLERS #

func _on_spawn_timer_timeout() -> void:
	#Crea otra instancia del dado
	spawn_dice()

func _on_fox_eating_dice() -> void:
	_score += 1
	score_label.text = "%04d" % _score

func _on_dice_off_screen() -> void:
	game_over_label.visible = true
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()

func reload() -> void:
	game_over_label.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()
