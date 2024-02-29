extends StaticBody2D

#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vidas: int = 1

# Propiedad exportada que se puede modificar desde el editor de Godot
@export var tipo: int:
	get:
		return tipo
	set(value):
		tipo = value

func _ready():
	if tipo == 1:
		vidas = 2 #queda sumar 1 por cada 8 niveles, al inicio 2, en nivel 9 seran 3

func hit():
	self.get_power_up()
	#if tipo != 2:
		#vidas = vidas -1
	#if vidas == 0:
		#self.queue_free()
	#if tipo == 1:
		#animation_player.play("grey hit")
	#if tipo == 2:
		#animation_player.play("gold hit")
	
func get_power_up():
	var animation_player = get_node("AnimationPlayer")
	var animation = animation_player.get_animation("power up")	
	#var sprite_track_index = animation.find_track("Sprite:texture")
	# Primero, cargamos el nuevo sprite.
	var powerUpSprite = preload("res://assets/blocks/Arcade - Arkanoid - Powerups.png")

	# Luego, obtenemos una referencia al Sprite y configuramos sus Hframes, Vframes y el frame específico.
	var sprite = get_node("powerUpSprite")
	sprite.texture = powerUpSprite
	sprite.hframes = 8
	sprite.vframes = 8
	sprite.frame = 1

	# Buscamos la pista de la animación que queremos modificar.

	# Buscamos la pista de la animación que queremos modificar.
	var sprite_track_index = -1
	for i in range(animation.get_track_count()):
		print("str(animation.track_get_path(i))", str(animation.track_get_path(i)))
		if str(animation.track_get_path(i)) == "powerUpSprite:frame":
			sprite_track_index = i
			break
	get_node("powerUpSprite").show()
	get_node("specialBlockSprite").hide()
	
	var duracion = animation.length
	print(duracion)
	
	# Si la pista existe...
	if sprite_track_index != -1:
		# Para cada frame del 0 al 8...
		var spriteFrameInicial = 1 * get_random_power_up()
		for frame in range(8):
		# Calculamos el tiempo para este frame.
			var tiempo = frame * 0.12

			# Configuramos el frame del sprite.
			sprite.frame = spriteFrameInicial + frame

			# Buscamos el fotograma clave en este tiempo.
			var key_index = animation.track_find_key(sprite_track_index, tiempo)

			# Si el fotograma clave existe...
			if key_index != -1:
				# ¡Cambiamos la textura!
				animation.track_set_key_value(sprite_track_index, key_index, sprite.frame)
			else:
				# Si no existe un fotograma clave en este tiempo, lo creamos.
				animation.track_insert_key(sprite_track_index, tiempo, sprite.frame)
		animation_player.play("power up")
		print(animation_player.is_playing())
		animation.loop = true

func get_random_power_up():
	randomize()  # Esto asegura que obtienes un número diferente cada vez que ejecutas el juego
	var numero = randi() % 7 * 8 # Genera un número aleatorio entre 0 y 99
	print(numero)  # Imprime el número aleatorio
	return numero
	#Power-up Rarity:
	#The power pills are completely random except that the extra life and 
	#warp pills are twice as unlikely to occur. Only one extra life pill is 
	#possible per Vaus. If the pill randomizer selects a duplicate pill based on
	 #the last pill dropped, a multi-ball pill is substituted. Thus, the multi-ball pill
	 #is the only one you can get twice in a row. The randomizer uses player score as the seed, 
	#so it is possible to control which pill is dispensed by purposely breaking pill dispensing blocks
	 #with specific scores displayed.
		
	#Ball Speed:
	#On each level, the ball will not speed up completely until it hits the back wall, so:
	#1) Try to remove bricks from the bottom up, or punch a hole through thicker areas of bricks rather than go straight through (e.g. take out the left side of level 2 rather than the single block at the right as you will catch far more pills).
	#2) If you have collected a lot of S pills and the ball has been in play for a bit of time, be prepared for a sudden speedup.
	#3) Also, the D token speeds up the balls and is pretty useless on most levels (the one with the enclosed diamond is the only good example).

	#Multiple Balls:
	#As only one pill can fall at a time, multiple balls can reduce your potential score quite drastically. Every pill is worth 1,000 points. For the first few levels, get every pill you can, but do not use the special powers. You will get a lot of extra ships and should get a gray P or two - thereby starting early with six or seven ships.

	#DOH:
	#In the final level, where you face DOH himself, you should get 15 hits (1,000 points per hit) on DOH/per man until you defeat DOH with the 16th hit on your last man to end the game.


