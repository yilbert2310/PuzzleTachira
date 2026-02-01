extends Sprite2D

var posicion_correcta : Vector2
var seleccionado = false
var puede_moverse = false # Esta variable controlará si se puede arrastrar

func _process(_delta):
	if seleccionado and puede_moverse:
		global_position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton and puede_moverse:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_rect().has_point(to_local(event.position)):
				seleccionado = true
				z_index = 1 
			else:
				if seleccionado:
					seleccionado = false
					z_index = 0
					verificar_posicion()

func verificar_posicion():
	if position.distance_to(posicion_correcta) < 30:
		position = posicion_correcta
		puede_moverse = false # Bloqueamos la pieza cuando encaja
		get_tree().current_scene.pieza_encajada()
