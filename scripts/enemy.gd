extends CharacterBody2D

var speed = 200  # Ajusta este valor a la velocidad que desees
@onready var agente = self.get_node("NavigationAgent2D") as NavigationAgent2D

func _ready():
	agente.target_location = Vector2(500 / 2, 500 / 2)

func _physics_process(delta):
	pass
	#var agente = self.get_node("NavigationAgent2D") as NavigationAgent2D
	#var direccion = agente.desired_velocity.normalized()
	#self.position += direccion * velocidad * delta
	#var dir = to_local(agente.get_next_path_position()).normalized()
	#velocity = dir * speed
	#move_and_slide()
	
func get_ball_enemy():
	var nueva_imagen = load("res://assets/blocks/ball-enemy-3.png")
	var sprite = self.get_node("EnemySprite")
	print(sprite)
	sprite.texture = nueva_imagen
	sprite.set_hframes(24)
	sprite.set_frame(0)
	var animation = self.get_node("AnimationPlayer")
	animation.play("ball enemy")
	
	
func get_blue_enemy():
	var nueva_imagen = load("res://assets/blocks/blue-enemy.png")
	var sprite = self.get_node("EnemySprite")
	print(sprite)
	sprite.set_texture(nueva_imagen)
	sprite.set_hframes(8)
	sprite.set_vframes(0)
	sprite.frame = 0
	var animation = self.get_node("AnimationPlayer")
	animation.play("blue enemy")
