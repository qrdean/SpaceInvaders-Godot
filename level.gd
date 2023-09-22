extends Node2D
class_name World

signal update_score_ui(score: int)
signal update_lives_ui(lives: int)

signal game_over_ui(text: String)

var player_score = 0
var player_lives = 3

var invaderlines = 3

@export var mothership: PackedScene

@onready var player = %Player
@onready var mothershipSpawn = %mothership_spawn
@onready var mothershipTimer = %MothershipTimer

func _ready():
	update_score_ui.emit(player_score)
	update_lives_ui.emit(player_lives)
	mothershipTimer.start()

func _on_player_spawn_bullet(gposition, bullet):
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = gposition
	new_bullet.add_to_group("bullet")
	add_child(new_bullet)


func _on_enemy_line_1_spawn_bullet(gposition, bullet):
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = gposition
	new_bullet.add_to_group("ebullet")
	new_bullet.connect("hit_player", _handle_player_hit)
	add_child(new_bullet)


func _on_enemy_line_2_spawn_bullet(gposition, bullet):
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = gposition
	new_bullet.add_to_group("ebullet")
	new_bullet.connect("hit_player", _handle_player_hit)
	add_child(new_bullet)


func _on_enemy_line_3_spawn_bullet(gposition, bullet):
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = gposition
	new_bullet.add_to_group("ebullet")
	new_bullet.connect("hit_player", _handle_player_hit)
	add_child(new_bullet)

func _handle_player_hit():
	player_lives -= 1
	update_lives_ui.emit(player_lives)
	if player_lives == 0 || player_lives < 0:
		player.queue_free()
		game_over_ui.emit("Game Over!")

func _on_enemy_line_1_invader_death():
	player_score += 1
	update_score_ui.emit(player_score)

func _on_enemy_line_2_invader_death():
	player_score += 1
	update_score_ui.emit(player_score)

func _on_enemy_line_3_invader_death():
	player_score += 1
	update_score_ui.emit(player_score)

func _on_enemy_line_1_all_invaders_dead():
	invaderlines -= 1
	if invaderlines == 0 || invaderlines < 1:
		game_over_ui.emit("Game Over You Win!")

func _on_enemy_line_2_all_invaders_dead():
	invaderlines -= 1
	if invaderlines == 0 || invaderlines < 1:
		game_over_ui.emit("Game Over You Win!")

func _on_enemy_line_3_all_invaders_dead():
	invaderlines -= 1
	if invaderlines == 0 || invaderlines < 1:
		game_over_ui.emit("Game Over You Win!")

func _on_mothership_timer_timeout():
	var newMothership = mothership.instantiate()
	newMothership.global_position = mothershipSpawn.get_global_position() 
	newMothership.connect("mothership_died", _on_mothership_mothership_died)
	add_child(newMothership)

func _on_mothership_mothership_died(player_kill):
	mothershipTimer.start()
	if player_kill:
		player_score += 10
		update_score_ui.emit(player_score)
