extends Node2D

#plane is child node of carrier
@onready var plane: Sprite2D = %Plane
@onready var helicopter: Sprite2D = $Helicopter
@onready var eating_sound: AudioStreamPlayer = $EatingSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#var dir: Vector2 = plane.position.direction_to(helicopter.position)
	
	plane.look_at(get_global_mouse_position())
	plane.move_local_x( 80.0 * delta)
	
	#plane.translate(Vector2.RIGHT * 60.0 * delta)
	#plane.global_translate(Vector2.RIGHT * 60.0 * delta)
	#plane.position.x += 100.0 * delta
	#plane.move_local_x(100.0 * delta) #segundo parametro 'scale:boolean'
	
	helicopter.position.x += 60.0 * delta
	#helicopter.position.y += 100.0 * delta
	#helicopter.move_local_x(60.0 * delta)
	#helicopter.rotate(-1.5 * delta)

	if Input.is_action_pressed("ui_left"):
		plane.rotate(-1.5 * delta)
	if Input.is_action_pressed("ui_right"):
		plane.rotate(1.5 * delta)

	if Input.is_action_just_pressed("ui_accept"):
		#eating_sound.play()
		#local position
		#plane.position = Vector2(350, 150)
		plane.global_position = Vector2(350, 150)


# los nodos hijos toman el eje en base a su padre. Si este roto, su eje tambien.
# Esto incluye cualquier tipo de propiedad aplicada a los hijos, incluso su escala.
# las propiedades 'global_' toman la posicion global, omitiendo la herencia del padre.

# Este codigo es util para que un elemento persiga a otro, mirando hacia el:
#	var dir: Vector2 = plane.position.direction_to(helicopter.position)
#	plane.look_at(helicopter.position)
#	plane.translate(dir * 60.0 * delta)
