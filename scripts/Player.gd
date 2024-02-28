extends CharacterBody2D

# Velocidad de movimiento

@export var speed: float = 1.5
@onready var height: float = $CollisionShape2D.get_shape().height

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction == Vector2(-1, 0) or direction == Vector2(1, 0):
		velocity += direction * speed
		move_and_collide(velocity)
		
	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO
