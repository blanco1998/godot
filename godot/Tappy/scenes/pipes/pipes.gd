class_name Pipes
extends Node2D



const BUFFER: float = 60.0
const SCROLL_SPEED: float = 100.0


@onready var notifier2D: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var timer: Timer = $Timer
@onready var upper: Area2D = $Upper
@onready var lower: Area2D = $Lower
#el laser lo hare con el editor para fines practicos
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	notifier2D.screen_exited.connect(_on_screen_exited)
	timer.timeout.connect(_on_timer_timeout)
	upper.body_entered.connect(_on_pipe_body_entered)
	lower.body_entered.connect(_on_pipe_body_entered)
	#el laser lo hare con el editor para fines practicos



func _physics_process(delta: float) -> void:
	scroll_speed(delta)



func scroll_speed(delta: float) -> void:
	position.x -= SCROLL_SPEED * delta


#signals
func _on_screen_exited() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()

func _on_pipe_body_entered(body: Node2D) -> void:
	#print("pipe: %s %s" % [name, body.name])
	if body is Tappy: body.die()


func _on_laser_body_entered(_body: Node2D) -> void:
	#print("laser: %s %s" % [name, body.name])
	score_sound.play()
	ScoreManager.add_point()
	
