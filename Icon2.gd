extends Sprite

#func _ready():
#	print("holisssss")
var time: float = 0

func _process(delta):
	time += delta
	rotation_degrees = 15 * sin(time)
