extends KinematicBody2D


export var vel_max_mover_suelo: float = 200
export var vel_mover_aire: float = 80
export var vel_saltar: float = -250
export var gravedad: float = 1
var velocidad: Vector2 = Vector2.ZERO
var yendo_parriba: bool = false
var snap: Vector2 = Vector2.ZERO

func _ready():
	print("holass")

func _input(event):
	if yendo_parriba && (is_on_floor() || event.is_action_released("saltar") || velocidad.y <= 0):
		#print("FIN")
		yendo_parriba = false
	if event.is_action_pressed("saltar"):
		#print("SALTA")
		yendo_parriba = true


func _physics_process(delta):
	var direccion: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("mover_derecha"):
		direccion = Vector2.RIGHT
		$PlayerSprite.flip_h = false
	if Input.is_action_pressed("mover_izquierda"):
		direccion = Vector2.LEFT
		$PlayerSprite.flip_h = true
	if is_on_floor():
		# velocidad.x = direccion.x * vel_max_mover_suelo
		velocidad.x = move_toward(velocidad.x, direccion.x * vel_max_mover_suelo, 200 * delta)
	else:
		velocidad.x = direccion.x * vel_mover_aire
		velocidad.y += gravedad
	if yendo_parriba:
		if is_on_floor():
			velocidad.y = vel_saltar * 0.5
		else:
			velocidad.y = move_toward(velocidad.y, vel_saltar, 400 * delta)

	if is_on_floor():
		if abs(velocidad.x) > 5:
			$PlayerSprite.play("camina") 
		else:
			$PlayerSprite.play("quieto")
	else:
		$PlayerSprite.play("salta")
	
	if abs(velocidad.x) > 150:
		$PlayerSprite.speed_scale = 2
	else:
		$PlayerSprite.speed_scale = 1
	
	if position.y > 1240:
		position.y = -20
	
	#print(is_on_floor())
	if is_on_floor():
		snap = Vector2.ZERO
	else:
		snap = position
	
	velocidad = move_and_slide_with_snap(velocidad, snap, Vector2.UP)
			
	
