extends StaticBody2D

# Propiedad exportada que se puede modificar desde el editor de Godot
@export var tipo: int:
	get:
		return tipo
	set(value):
		tipo = value

func hit():
	self.queue_free()
