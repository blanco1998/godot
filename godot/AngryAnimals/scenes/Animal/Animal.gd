class_name Animal

extends RigidBody2D


const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)


@onready var debuggin_label: Label = $Debuggin
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound


var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _is_dragging: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var debug_str: String = "F: %s | CC: %d | S: %s" %[freeze, get_contact_count(), sleeping]
	debug_str += "\nis_dragging: %s | drag_start: %.0f | %.0f" % [_is_dragging, _drag_start.x, _drag_start.y]
	debug_str += "\ndragged_vector: %.0f | %.0f" % [_dragged_vector.x, _dragged_vector.y]
	debuggin_label.text = debug_str

func _physics_process(delta: float) -> void:
	if _is_dragging: handle_dragging()



func start_dragging() -> void:
	arrow.show()
	_is_dragging = true
	_drag_start = get_global_mouse_position()

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	var diff: Vector2 = new_dragged_vector - _dragged_vector
	if diff.length() > 0 and !stretch_sound.playing: 
		stretch_sound.play()
	_dragged_vector = new_dragged_vector
	position = _start + _dragged_vector



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		input_event.disconnect(_on_input_event)
		start_dragging()
