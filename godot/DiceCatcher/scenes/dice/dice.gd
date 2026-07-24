class_name Dice
extends Area2D


signal off_screen

const SPEED: float = 100.0
const ROTATION_SPEED: float = 2 * PI
const BUFFER: float = 60.0


@onready var sprite_2d: Sprite2D = $Sprite2D

var _rotation_speed: float = ROTATION_SPEED


func _ready() -> void:
	speed_direction()
	generate_dice()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	gravity(delta)
	rotation(delta)
	check_off_Screen()

#Genera la velocidad de caida
func gravity(delta) -> void:
	position.y += SPEED * delta

#En base a _rotation_speed aplica el sentido de rotacion
func rotation(delta) -> void:
	sprite_2d.rotate(_rotation_speed * delta)

#En base al randf() decide si es positivo o negativo
func speed_direction() -> void:
	if randf() < 0.5: _rotation_speed *= -1 

#Detecta si salio de pantalla con get_viewport_rect.end.y 
#(fin del eje Y del dado) y detiene el juego
func check_off_Screen() -> void:
	if get_viewport_rect().end.y < position.y:
		get_tree().paused = true
		off_screen.emit()
		queue_free()

#generar aleatoriamente dados en el eje x del viewport
func generate_dice() -> void:
	position.x = randf_range(
		get_viewport_rect().position.x + BUFFER, 
		get_viewport_rect().end.x - BUFFER)
	position.y = get_viewport_rect().position.y - BUFFER
