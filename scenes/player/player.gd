extends Area2D

signal pickup

@export var speed: float = 500

var velocity: Vector2 = Vector2.ZERO
var screensize: Vector2i = Vector2i(480, 720)

func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down")
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if(velocity.length() > 0):
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if(velocity.x != 0):
		$AnimatedSprite2D.flip_h = velocity.x < 0;
		
func start():
	set_process(true)
	position = screensize * 0.5
	$AnimatedSprite2D.animation = "idle"

func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit()
























