extends CharacterBody2D

const START_SPEED : int = 500
const ACCEL : int = 5
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.75

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new_ball():
	speed = START_SPEED
	dir = random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	if collision:
		var collider = collision.get_collider()
		#if ball hits paddle
		if collider == $"../Player":
			speed += ACCEL
			dir = new_direction(collider)
		#if it hits a wall
		else:
			dir = dir.bounce(collision.get_normal())
		if collider.has_method("hit"):
			collider.hit()


func random_direction():
	var new_dir := Vector2()
	new_dir.y = -1
	new_dir.x = 0.25
	return new_dir.normalized()

func new_direction(collider):
	var ball_x = position.x
	var pad_x = collider.position.x
	var dist = ball_x - pad_x + 8
	var new_dir := Vector2()
	
	#flip the horizontal direction
	if dir.y > 0:
		new_dir.y = -1
	else:
		new_dir.y = 1
	new_dir.x = (dist / (collider.height / 2.75 )) * MAX_Y_VECTOR
	return new_dir.normalized()
