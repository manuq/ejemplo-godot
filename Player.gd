extends KinematicBody2D


export var vel_mover_suelo: float = 160
export var vel_mover_aire: float = 80
export var vel_saltar: float = -250
export var gravedad: float = 1
var velocidad: Vector2 = Vector2.ZERO

func _ready():
	print("holass")


func _physics_process(_delta):
	var direccion: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("mover_derecha"):
		direccion = Vector2.RIGHT
		$PlayerSprite.flip_h = false
	if Input.is_action_pressed("mover_izquierda"):
		direccion = Vector2.LEFT
		$PlayerSprite.flip_h = true
	if is_on_floor():
		velocidad.x = direccion.x * vel_mover_suelo
	else:
		velocidad.x = direccion.x * vel_mover_aire
		velocidad.y += gravedad
	if Input.is_action_just_pressed("saltar") && is_on_floor():
		velocidad.y += vel_saltar

	if is_on_floor():
		if velocidad != Vector2.ZERO:
			$PlayerSprite.play("camina") 
		else:
			$PlayerSprite.play("quieto")
	else:
		$PlayerSprite.play("salta")
	
	if position.y > 240:
		position.y = -20
	velocidad = move_and_slide(velocidad, Vector2.UP)
