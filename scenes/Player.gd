extends CharacterBody2D

# Velocidad de movimiento
@export var speed: float = 200

# Límites de movimiento
var min_x: float = 0
var max_x: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Obtener los límites de movimiento a partir de las colisiones de los nodos hijos
	for child in get_children():
		if child.has_method("get_collision_box"):
			var collision_box = child.get_collision_box()
			min_x = collision_box.position.x - collision_box.size.x / 2
			max_x = collision_box.position.x + collision_box.size.x / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity += direction * 50
	move_and_slide() 
	# Movimiento horizontal
	#var move_dir = 0
	#if Input.is_action_pressed("ui_left"):
		#move_dir -= 1
	#if Input.is_action_pressed("ui_right"):
		#move_dir += 1
	#
	#var velocity = Vector2(move_dir * speed * delta, 0)
	#move_and_slide(velocity)
#
	## Limitar el movimiento dentro de los límites obtenidos
	#position.x = clamp(position.x, min_x, max_x)


#extends StaticBody2D
#
#var win_height : int
#var p_height : int
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#win_height = get_viewport_rect().size.y
	#print($CollisionShape2D.shape)
	#p_height = $CollisionShape2D.shape.radius
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_pressed("ui_left"):
		#position.y -= get_parent().PADDLE_SPEED * delta
	#elif Input.is_action_pressed("ui_right"):
		#position.y += get_parent().PADDLE_SPEED * delta
#
	##limit paddle movement to window
	#position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
