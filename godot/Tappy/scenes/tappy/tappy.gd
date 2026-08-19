class_name Tappy
extends CharacterBody2D


const JUMP_FORCE: float = -350.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _jump: bool = false



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		_jump = true


func _physics_process(delta: float) -> void:
	gravity_acceleration(delta)
	
	if is_on_floor(): die()



func gravity_acceleration(delta: float) -> void:
	velocity.y += _gravity * delta
	#velocity - inherited from CharacterBody2D
	
	if _jump:
		velocity.y = JUMP_FORCE
		_jump = false
		animation_player.play("fly")
		
	move_and_slide()


func die() -> void:
	SignalHub.emit_tappy_died()
	get_tree().paused = true
