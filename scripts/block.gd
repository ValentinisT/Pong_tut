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
	
	get_animation(tipo)
	if tipo != 2:
		vidas = vidas -1
	if vidas == 0:
		self.get_power_up()

func get_animation(tipo: int):
	var animation_player = get_node("AnimationPlayer")
	if (tipo == 1):
		animation_player.play("grey hit")
	if (tipo == 2):
		animation_player.play("gold hit")
	
func get_power_up():
	var animation_player = get_node("AnimationPlayer")

	# Generamos un número aleatorio para seleccionar la animación.
	var power_up_type = get_random_power_up()

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
	var animation = animation_player.get_animation(animation_name)
	animation_player.play(animation_name)
	get_node("powerUpSprite").show()
	get_node("specialBlockSprite").hide()
	animation.loop = true



func get_random_power_up():
	randomize()  # Esto asegura que obtienes un número diferente cada vez que ejecutas el juego
	var numero = randi() % 6 # Genera un número aleatorio entre 0 y 99
	print(numero)  # Imprime el número aleatorio
	return numero


