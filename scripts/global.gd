extends Node

#·rojo 0 #azul 1 #fucsia 2 #amarillo 3 #blanco 4
#naranja 5 #celeste 6 #verde 7 #gris 8 #dorado 9
var levelBlocks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar levelBlocks como un array de 2 niveles
	for i in range(13):
		var row = []
		for j in range(13):
			row.append([])
		levelBlocks.append(row)

func level1():
	var blocks = [8, 0, 3, 1, 2, 7]
	var block_count = blocks.size()
	for i in range(6):
		for j in range(13):
			levelBlocks[i][j] = blocks[i]
