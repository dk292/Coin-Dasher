extends Node

@export var coin_scene: PackedScene

var level: int = 1
var screensize: Vector2i;
# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().get_visible_rect().size
	$Player.start()	
	spawn_coins()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_coins():
	for i in level + 4:
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
		
