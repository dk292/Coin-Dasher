extends Node

@export var coin_scene: PackedScene
@export var powerup_scene: PackedScene
@export var play_time: float

var playing: bool = false
var level: int = 0
var screensize: Vector2i
var time_left: float
var score: int = 0

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()	

func _process(_delta):
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		spawn_coins()
		$PowerUpTimer.wait_time = randi_range(4, 8)
		$PowerUpTimer.start()

func spawn_coins():
	$LevelSound.play()
	for i in level + 4:
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.screensize = screensize
		coin.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))

func new_game():
	$LevelSound.play()
	playing = true
	time_left = play_time
	level = 1
	score = 0
	$GameTimer.start()
	$Hud.update_score(score)
	$Hud.update_timer(time_left)
	$Player.show()
	$Player.start()
	
func game_over():
	$EndSound.play()
	playing = false;
	$Hud.show_game_over()
	$GameTimer.stop()
	$PowerUpTimer.stop()
	get_tree().call_group("coins", "queue_free")
	$Player.die()
	
func _on_hud_start_game_sgn():
	new_game()

func _on_game_timer_timeout():
	time_left -= 1
	$Hud.update_timer(time_left)
	if time_left <= 0:
		game_over()
		
func _on_player_pickup(type):
	match type:
		"coins":
			$CoinSound.play()
			score += 1
			$Hud.update_score(score)
		"powerups":
			$PowerUpSound.play()
			time_left += 5
			$Hud.update_timer(time_left)

func _on_power_up_timer_timeout():
	var powerup = powerup_scene.instantiate()
	add_child(powerup)
	powerup.screensize = screensize
	powerup.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))

func _on_player_hurt():
	game_over()


