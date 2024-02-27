extends Node

#·rojo 0 #azul 1 #fucsia 2 #amarillo 3 #blanco 4
#naranja 5 #celeste 6 #verde 7 #gris 8 #dorado 9
var levelBlocks = []
var filas = 22
var columnas = 13
var ROJO = 0; var AZUL = 1; var FUCSIA = 2; var AMARILLO = 3; var BLANCO = 4; var NARANJA = 5; var CELESTE = 6; var VERDE = 7; var GRIS = 8; var DORADO = 9




# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicializar levelBlocks como un array de 2 niveles
	for i in range(filas):
		var row = []
		for j in range(columnas):
			row.append(-1)
		levelBlocks.append(row)

func level1():
	var blocks = [-1,-1, 8, 0, 3, 1, 2, 7]
	var block_count = blocks.size()
	for i in range(filas):
		for j in range(columnas):
			if (i < blocks.size()):
				levelBlocks[i][j] = blocks[i]
			else:
				levelBlocks[i][j] = -1

func level2():
	var blocks = [4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2]
	var line = []
	for i in range(blocks.size()-2):
		print("line",line)
		line.append(blocks[i])		
		self.replace_line(i+2, line)
	self.replace_line(0,-1)
	self.replace_line(1,-1)
	self.replace_line(14, [GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,GRIS,ROJO])
	 
	
func level3():
	self.replace_line(3, VERDE)
	self.replace_line(5, [BLANCO,BLANCO,BLANCO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO])
	self.replace_line(7, ROJO)
	self.replace_line(9, [DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,BLANCO,BLANCO,BLANCO])	
	self.replace_line(11, FUCSIA)
	self.replace_line(13, [AZUL,AZUL,AZUL,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO])	
	self.replace_line(15, CELESTE)
	self.replace_line(17, [DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,DORADO,CELESTE,CELESTE,CELESTE])	
	
func replace_line(fila: int, arrayOrNumero):    
	var new_array = []

	if arrayOrNumero is Array:
		for element in arrayOrNumero:
			new_array.append(element)
		while len(new_array) < 13:
			new_array.append(-1)
		print("new_array", new_array)
		levelBlocks[fila] = new_array
	elif arrayOrNumero is int:
		for i in range(13):
			new_array.append(arrayOrNumero)
		print(new_array)
		levelBlocks[fila] = new_array


