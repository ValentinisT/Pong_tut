extends StaticBody2D

#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vidas: int = 1
signal vidas_agotadas(position)

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
	get_animation()
	if tipo != 2:
		vidas = vidas -1
	if vidas == 0:
		vidas_agotadas.emit(self.position)
		self.queue_free()


func get_animation():
	var animation_player = get_node("AnimationPlayer")
	if (tipo == 1):
		animation_player.play("grey hit")
	if (tipo == 2):
		animation_player.play("gold hit")
