extends CharacterBody2D

# Velocidad de movimiento
@export var speed: float = 1.5
@onready var height: float = $CollisionShape2DNormal.get_shape().height
signal power_up_player(tipo)

var animation_player
var VausNormal
var VausExtendido
var TransformaAArma
var VausArmadoLaser
var CollisionShape2DNormal
var CollisionShape2DExtendido
var CollisionShape2DLaser

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node("AnimationPlayer")
	VausNormal = get_node("VausNormal")
	VausExtendido = get_node("VausExtendido")
	TransformaAArma = get_node("TransformaAArma")
	VausArmadoLaser = get_node("VausArmadoLaser")
	CollisionShape2DNormal = get_node("CollisionShape2DNormal")
	CollisionShape2DExtendido = get_node("CollisionShape2DExtendido")
	CollisionShape2DLaser = get_node("CollisionShape2DLaser")
	animation_player.play("vaus normal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction == Vector2(-1, 0) or direction == Vector2(1, 0):
		velocity += direction * speed
		var collision = move_and_collide(velocity)
		if !$"..".ball_timer_executed and !collision:
			$"../Ball".move_and_collide(velocity)
		if collision:
			var collider = collision.get_collider()
			print(collider)
			if collider and "tipo" in collider:
				on_power_up_collision(collider.tipo)
				collider.queue_free()

	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO

func on_power_up_collision(tipo: int):
	if(tipo == 3 and !VausArmadoLaser.visible):
		if(VausExtendido.visible):
			getBigOrShrink(false)
		animation_player.stop()
		VausNormal.hide()
		TransformaAArma.show()
		animation_player.play("vaus a laser")
	if(tipo == 4):
		#falta animacion de peque a grande
		self.getBigOrShrink(true)
	#obtener sprite vausNormaly ocultarlo
	power_up_player.emit(tipo)
	print("colision power up", tipo)

func getBigOrShrink(getBig:bool):
	if(getBig):
		VausNormal.hide()
		VausExtendido.show()
		CollisionShape2DNormal.set_deferred("disabled", true)
		CollisionShape2DExtendido.set_deferred("disabled", false)
	else:
		VausNormal.show()
		VausExtendido.hide()
		CollisionShape2DNormal.set_deferred("disabled", false)
		CollisionShape2DExtendido.set_deferred("disabled", true)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "vaus a laser":
		# Aquí puedes hacer aparecer tu otro sprite
		TransformaAArma.hide()
		VausArmadoLaser.show()
		animation_player.play("vaus laser") 
		CollisionShape2DNormal.set_deferred("disabled", true)
		CollisionShape2DExtendido.set_deferred("disabled", true)
		CollisionShape2DLaser.set_deferred("disabled", false)
