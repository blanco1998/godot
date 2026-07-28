extends CharacterBody2D

const JUMP_FORCE: float = -350.0

@onready var label: Label = $Label

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _jump: bool = false



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		_jump = true


func _physics_process(delta: float) -> void:
	gravity_acceleration(delta)



func gravity_acceleration(delta: float) -> void:
	velocity.y += _gravity * delta
	#velocity - inherited from CharacterBody2D
	
	if _jump:
		velocity.y = JUMP_FORCE
		_jump = false
		
	move_and_slide()
	
	
	label.text = "is_on_floor: %s\n" % is_on_floor()
	label.text += "is_on_wall: %s\n" % is_on_wall()
	label.text += "is_on_ceiling: %s\n" % is_on_ceiling()
