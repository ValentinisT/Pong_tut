extends Node2D

var block = preload("res://scenes/block.tscn")
var powerUp = preload("res://scenes/powerUp.tscn")
var ball = preload("res://scenes/ball.tscn")
var ball_timer_executed = false
var balas = preload("res://scenes/balas.tscn")
var gameBall = null # Variable para almacenar la referencia a la bala
var gameBall2 = null # Variable para almacenar la referencia a la bala
var gameBall3 = null # Variable para almacenar la referencia a la bala

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level1()
	
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

func create_ball():
	gameBall = ball.instantiate() # Creas la instancia de la bala
	gameBall.position.x = 563
	gameBall.position.y = 573
	add_child(gameBall) # Añades la bala como hijo del nodo actual

func _on_ball_timer_timeout():
	ball_timer_executed = true
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
	var new_bala = balas.instantiate()
	new_bala.scale.x = 2.5
	new_bala.scale.y = 2.5
	new_bala.position.x = posx - 8
	new_bala.position.y = posy +  randi_range(-5, 0)
	add_child(new_bala)
