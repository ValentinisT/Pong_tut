extends Node2D

var block = preload("res://scenes/block.tscn")
var powerUp = preload("res://scenes/powerUp.tscn")
var ball = preload("res://scenes/ball.tscn")
var laser = preload("res://scenes/laser.tscn")
var enemy = preload("res://scenes/enemy.tscn")
var ball_timer_executed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level2()
	
	for i in range(Global.filas):
		for j in range(Global.columnas):
			if Global.levelBlocks[i][j] < 0:
				continue
			var posX = 16 * 2.5 * j
			var posY = 8 * 2.5 * i
			var new_block = block.instantiate()  # Instanciar el nodo
			new_block.position.x = 335 + posX # Establecer la coordenada X deseada
			new_block.position.y = 85 + posY  # Establecer la coordenada Y deseada
			new_block.scale.x = 2.5
			new_block.scale.y = 2.5
			var sprite = new_block.get_node("blockSprite")  # Obtener el nodo Sprite dentro de block.tscn
			var specialSprite = new_block.get_node("specialBlockSprite")
			new_block.vidas_agotadas.connect(Callable(self, "_on_vidas_agotadas"))
			add_child(new_block)  # Agregar el nodo como hijo
			new_block.tipo = 0
			if Global.levelBlocks[i][j] > 7:
				new_block.tipo = 1
				new_block.vidas = 2
				new_block.get_node("blockSprite").hide()
				new_block.get_node("specialBlockSprite").show()
				var val = 6
				if Global.levelBlocks[i][j] == 9:
					val = 0
					new_block.tipo = 2
				specialSprite.frame = val
			else:
				new_block.get_node("blockSprite").show()
				new_block.get_node("specialBlockSprite").hide()
				sprite.frame = Global.levelBlocks[i][j]
	create_ball()
	#enemigos deshabilitados de momento para no hacer path finding
	#var ene = enemy.instantiate() # Creas la instancia de la bala
	#ene.position.x = 563 + 100
	#ene.position.y = 573
	#ene.get_blue_enemy()
	#add_child(ene) # Añades la bala como hijo del nodo actual
	#
	#var ene2 = enemy.instantiate() # Creas la instancia de la bala
	#ene2.position.x = 563 + 200
	#ene2.position.y = 573
	#ene2.get_ball_enemy()
	#add_child(ene2) # Añades la bala como hijo del nodo actual
	
func _process(delta):
	if not ball_timer_executed and Input.is_action_just_pressed("shoot"):
		var ball_timer = get_node("BallTimer")
		ball_timer.stop()
		_on_ball_timer_timeout()

func create_ball():
	var gameBall = ball.instantiate() # Creas la instancia de la bala
	gameBall.position.x = 563
	gameBall.position.y = 589
	add_child(gameBall) # Añades la bala como hijo del nodo actual

func _on_ball_timer_timeout():
	ball_timer_executed = true
	var gameBall = get_tree().get_nodes_in_group("balls")[0]
	if gameBall != null: # Compruebas si la bala existe
		gameBall.new_ball() # Si existe, ejecutas la función gameBall


func _on_vidas_agotadas(position):
	randomize()  # Esto asegura que obtienes un número diferente cada vez que ejecutas el juego
	var create_power_up = randi() % 2 # Genera un número aleatorio entre 0 y 99
	if create_power_up == 1 :
		var new_powerUp = powerUp.instantiate()  # Instanciar el nodo
		new_powerUp.position.x = position.x
		new_powerUp.position.y = position.y
		new_powerUp.scale.x = 2.5
		new_powerUp.scale.y = 2.5
		new_powerUp.power_up_player.connect(Callable(self, "_on_power_up_player"))
		new_powerUp.tipo = get_random_power_up()
		add_child(new_powerUp)  # Agregar el nodo como hijo

func get_random_power_up():
	randomize()  # Esto asegura que obtienes un número diferente cada vez que ejecutas el juego
	var numero = randi() % 6 # Genera un número aleatorio entre 0 y 99
	return numero
	
func _on_power_up_player(tipo: int):
	if (tipo == 5):
		disruption()
	if (tipo == 1):
		for ball in get_tree().get_nodes_in_group("balls"):
			ball.speed = ball.START_SPEED
	else:
		$Player.on_power_up_collision(tipo)
		
func create_ball_aux(rotation_degrees):
	var gameBall = get_tree().get_nodes_in_group("balls")[0] # Obtiene el primer nodo de tipo 'ball' en el grupo 'balls'
	var new_ball = ball.instantiate() # Creas la instancia de la bala
	new_ball.position = gameBall.position
	new_ball.dir = gameBall.dir.rotated(deg_to_rad(rotation_degrees)) # Rotas los grados especificados
	new_ball.speed = gameBall.speed
	add_child(new_ball) # Añades la bala como hijo del nodo actual

func disruption():
	create_ball_aux(5)  # Creas la primera bola rotada 5 grados
	create_ball_aux(-5) # Creas la segunda bola rotada -5 grados

func _on_player_create_bullet(posx, posy):
	var new_bala = laser.instantiate()
	new_bala.scale.x = 2.5
	new_bala.scale.y = 2.5
	new_bala.position.x = posx - 8
	new_bala.position.y = posy +  randi_range(-20, -15)
	add_child(new_bala)
