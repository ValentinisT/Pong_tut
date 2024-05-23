extends CharacterBody2D

var speed = 150  # Ajusta este valor a la velocidad que desees
@onready var agente = self.get_node("NavigationAgent2D") as NavigationAgent2D

func _ready():
	agente.target_location = Vector2(640, 350)

func _physics_process(delta):
	var direction = Vector2()
	agente.target_position = get_global_mouse_position()
	#agente.target_position = Vector2(640, 350)
	direction = (agente.get_next_path_position() - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func destroy(playAnim:bool):
	queue_free()

	
func get_ball_enemy():
	var nueva_imagen = load("res://assets/blocks/ball-enemy-3.png")
	var sprite = self.get_node("EnemySprite")
	sprite.texture = nueva_imagen
	sprite.set_hframes(24)
	sprite.set_vframes(1)
	sprite.set_frame(0)
	var animation = self.get_node("AnimationPlayerLoop")
	animation.play("ball enemy")
	
	
func get_blue_enemy():
	var nueva_imagen = load("res://assets/blocks/blue-enemy.png")
	var sprite = self.get_node("EnemySprite")
	sprite.set_texture(nueva_imagen)
	sprite.set_hframes(8)
	sprite.set_vframes(1)
	sprite.frame = 0
	var animation = self.get_node("AnimationPlayerLoop")
	animation.play("blue enemy")


func get_green_enemy():
	var nueva_imagen = load("res://assets/blocks/green-enemy.png")
	var sprite = self.get_node("EnemySprite")
	sprite.set_texture(nueva_imagen)
	sprite.set_hframes(6)
	sprite.set_vframes(2)
	sprite.frame = 0
	var animation = self.get_node("AnimationPlayerLoop")
	animation.play("green enemy")
	
func get_red_enemy():
	var nueva_imagen = load("res://assets/blocks/red-enemy.png")
	var sprite = self.get_node("EnemySprite")
	print(sprite)
	sprite.set_texture(nueva_imagen)
	sprite.set_hframes(5)
	sprite.set_vframes(2)
	sprite.frame = 0
	var animation = self.get_node("AnimationPlayerGoAndReturn")
	animation.play("red enemy")
