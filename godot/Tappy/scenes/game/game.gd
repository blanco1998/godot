extends Node

@export var pipes_scene: PackedScene

@onready var upper_spawn: Marker2D = $UpperSpawn
@onready var lower_spawn: Marker2D = $LowerSpawn
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.score_restored()
	spawn_pipes()
	spawn_timer.timeout.connect(_on_timeout_spawn)


func _on_timeout_spawn() -> void:
	spawn_pipes()


func spawn_pipes() -> void:
	var new_pipe: Pipes = pipes_scene.instantiate()
	
	var y_pos: float = randf_range(
		upper_spawn.position.y,
		lower_spawn.position.y
	)
	
	new_pipe.position = Vector2(upper_spawn.position.x, y_pos)
	pipes_holder.add_child(new_pipe)
