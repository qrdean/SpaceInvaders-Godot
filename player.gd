extends CharacterBody2D
class_name Player

const SPEED = 300.0
@export var bullet: PackedScene

@onready var ReloadTimer = %Reload

var can_shoot = true

signal spawn_bullet(gposition: Vector2, bullet: PackedScene)

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("fire") && can_shoot:
		spawn_bullet.emit($bulletspawn.get_global_position(), bullet)
		can_shoot = false
		ReloadTimer.start()

	move_and_slide()


func _on_reload_timeout():
	can_shoot = true
