extends Node2D

@export var imagen_santo_cristo : Texture2D 
var piezas_colocadas = 0
var lista_de_piezas = [] 

func _ready():
	if has_node("MensajeVictoria"):
		$MensajeVictoria.hide()
	
	var columnas = 3
	var filas = 3
	var escala_puzzle = 0.4 
	var margen_x = 340
	var margen_y = 191
	
	var tamano_imagen = imagen_santo_cristo.get_size()
	var tamano_pieza = Vector2(tamano_imagen.x / columnas, tamano_imagen.y / filas)
	
	for y in range(filas):
		for x in range(columnas):
			var nueva_pieza = load("res://pieza.tscn").instantiate()
			nueva_pieza.texture = imagen_santo_cristo
			nueva_pieza.region_enabled = true
			nueva_pieza.region_rect = Rect2(x * tamano_pieza.x, y * tamano_pieza.y, tamano_pieza.x, tamano_pieza.y)
			nueva_pieza.scale = Vector2(escala_puzzle, escala_puzzle)
			
			var pos_x = ((x * tamano_pieza.x + tamano_pieza.x / 2) * escala_puzzle) + margen_x
			var pos_y = ((y * tamano_pieza.y + tamano_pieza.y / 2) * escala_puzzle) + margen_y
			nueva_pieza.posicion_correcta = Vector2(pos_x, pos_y)
			
			# Aparecen armadas y bloqueadas
			nueva_pieza.position = nueva_pieza.posicion_correcta
			nueva_pieza.puede_moverse = false 
			
			$ContenedorDePiezas.add_child(nueva_pieza)
			lista_de_piezas.append(nueva_pieza)

func pieza_encajada():
	piezas_colocadas += 1
	if piezas_colocadas == 9:
		$MensajeVictoria.show()
		$BotonJugar.text = "REINTENTAR"
		$BotonJugar.show()
		$BotonSalir.show()

func _on_boton_jugar_pressed():
	piezas_colocadas = 0
	$MensajeVictoria.hide()
	$BotonJugar.hide()
	$BotonSalir.hide()
	
	# Usamos el nombre que tienes en tu escena para el texto
	if has_node("Titulo2"): 
		$Titulo2.hide()
	
	# DESORDENAR
	for pieza in lista_de_piezas:
		pieza.puede_moverse = true # Activamos el movimiento
		if randf() > 0.5:
			pieza.position = Vector2(randf_range(50, 250), randf_range(100, 600))
		else:
			pieza.position = Vector2(randf_range(1030, 1230), randf_range(100, 600))

func _on_boton_salir_pressed():
	get_tree().quit()	
