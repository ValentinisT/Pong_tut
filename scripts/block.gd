extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vidas: int = 1

# Propiedad exportada que se puede modificar desde el editor de Godot
@export var tipo: int:
	get:
		return tipo
	set(value):
		tipo = value

func _ready():
	print("tipo", tipo)	
	if tipo == 1:
		vidas = 2	

func hit():
	print("tipo: ",tipo)
	print("vidas: ",vidas)
	if tipo != 2:
		vidas = vidas -1
	if vidas == 0:
		self.queue_free()
	if tipo == 1:
		animation_player.play("grey hit")
	if tipo == 2:
		animation_player.play("gold hit")
	
	
