extends CharacterBody2D

@export var tipo: int:
	get:
		return tipo
	set(value):
		tipo = value
		
const SPEED : int = 100
const ACCEL : int = 5
var dir : Vector2 = Vector2(0,1)
signal power_up_player(tipo)
		
func _ready():
	get_power_up(tipo)
	
func _physics_process(delta):
	var collision = move_and_collide(dir * SPEED * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player":
			power_up_player.emit(tipo)
		queue_free()
			
func get_power_up(power_up_type):
	var animation_player = get_node("AnimationPlayer")
	# Usamos un 'match' (equivalente a 'switch' en otros lenguajes) para seleccionar la animación.
	var animation_name
	match power_up_type:
		0:
			animation_name = "Player pill"
		1:
			animation_name = "slow pill"
		2:
			animation_name = "catch pill"
		3:
			animation_name = "Laser pill"
		4:
			animation_name = "Enlarge pill"
		5:
			animation_name = "Disruption pill"
		6:
			animation_name = "Break pill"
			
	# Obtenemos la animación y la reproducimos.
	animation_player.play(animation_name)
