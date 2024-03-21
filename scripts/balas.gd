extends CharacterBody2D

const dir = Vector2(0, -200) # Define la velocidad vertical
const speed : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = dir * speed * delta
	var collision = move_and_collide(velocity)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider.has_method("hit"):
			collider.hit()
		queue_free()
