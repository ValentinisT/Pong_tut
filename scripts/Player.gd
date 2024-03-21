extends CharacterBody2D

# Velocidad de movimiento
@export var speed: float = 1.5
@onready var height: float = $CollisionShape2DNormal.get_shape().height
signal power_up_player(tipo)
signal create_bullet(posx,posy)
var shootTimer 
var animation_player
var VausNormal
var VausExtendido
var TransformaAArma
var VausArmadoLaser
var CollisionShape2DNormal
var CollisionShape2DExtendido
var CollisionShape2DLaser
var VausAnimInicio

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const ZERO = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node("AnimationPlayer")
	VausNormal = get_node("VausNormal")
	VausAnimInicio = get_node("VausAnimInicio")
	VausExtendido = get_node("VausExtendido")
	TransformaAArma = get_node("TransformaAArma")
	VausArmadoLaser = get_node("VausArmadoLaser")
	CollisionShape2DNormal = get_node("CollisionShape2DNormal")
	CollisionShape2DExtendido = get_node("CollisionShape2DExtendido")
	CollisionShape2DLaser = get_node("CollisionShape2DLaser")
	shootTimer = get_node("ShootTimer")
	
	animation_player.play("inicio")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction != ZERO:
		velocity += direction * speed
		var collision = move_and_collide(velocity)
		if !$"..".ball_timer_executed and !collision:
			$"../Ball".move_and_collide(velocity)
		if collision:
			var collider = collision.get_collider()
			if collider and "tipo" in collider:
				on_power_up_collision(collider.tipo)
				collider.queue_free()
	else:
		velocity = ZERO
	if Input.is_action_just_pressed("shoot")  and VausArmadoLaser.visible and shootTimer.is_stopped():
		create_bullet.emit(position.x,position.y)
		shootTimer.start() # Inicia el Timer

func on_power_up_collision(tipo: int):
	# laser
	if(tipo == 3 and !VausArmadoLaser.visible):
		if(VausExtendido.visible):
			getBigOrShrink(false)
		animation_player.stop()
		VausAnimInicio.hide()
		VausNormal.hide()
		VausArmadoLaser.hide()
		TransformaAArma.show()
		animation_player.play("vaus a laser")
	# enlarge
	if(tipo == 4):
		if(VausArmadoLaser.visible):
			VausArmadoLaser.hide()
			VausNormal.hide()
			TransformaAArma.show()
			animation_player.play("vaus laser a normal")
			#VausNormal.show()		
		#falta animacion de peque a grande
		#self.getBigOrShrink(true)
	#obtener sprite vausNormaly ocultarlo
	power_up_player.emit(tipo)

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
	if anim_name == "vaus laser a normal":
		TransformaAArma.hide()
		VausExtendido.show()
		CollisionShape2DNormal.set_deferred("disabled", true)
		CollisionShape2DExtendido.set_deferred("disabled", false)
		CollisionShape2DLaser.set_deferred("disabled", true)
		
	if anim_name == "vaus a laser":
		# Aquí puedes hacer aparecer tu otro sprite
		TransformaAArma.hide()
		VausArmadoLaser.show()
		animation_player.play("vaus laser") 
		CollisionShape2DNormal.set_deferred("disabled", true)
		CollisionShape2DExtendido.set_deferred("disabled", true)
		CollisionShape2DLaser.set_deferred("disabled", false)
	if anim_name == "inicio":
		VausAnimInicio.hide()
		VausNormal.show()
		animation_player.play("vaus normal")


func _on_shoot_timer_timeout():  
	shootTimer.stop()
	pass # Replace with function body.
