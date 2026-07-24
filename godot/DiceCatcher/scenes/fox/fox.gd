class_name Fox
extends Area2D


signal eating_dice

@export var speed: float = 400.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	fox_move_v2(delta)
	

func fox_move(delta) -> void:
	var move_left: bool = Input.is_action_pressed("fox_left")
	var move_right: bool = Input.is_action_pressed("fox_right")
	
	var move: float = 0.0
	if move_left: move -= 1.0
	if move_right: move += 1.0
	
	position.x += move * delta * speed

func fox_move_v2(delta) -> void:
	var move: float = Input.get_axis("fox_left", "fox_right")
	position.x += move * delta * speed
	
	if !is_zero_approx(move):
		sprite_2d.flip_h = move > 0.0

#Accion callback del signal de colisiones (area 2d)
func _on_area_entered(area: Area2D) -> void:
	eat_dice(area)

func eat_dice(area: Area2D) -> void:
	if area is Dice:
		area.queue_free() #liberar el cuerpo recibido
		audio_stream_player_2d.play()
		eating_dice.emit() #Emitir señal eating_dice
