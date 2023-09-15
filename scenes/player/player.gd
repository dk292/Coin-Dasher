extends CharacterBody2D

@export var speed: float = 500

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if(direction.length() > 0):
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if(velocity.x != 0):
		$AnimatedSprite2D.flip_h = velocity.x < 0;
