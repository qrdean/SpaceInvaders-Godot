extends Area2D
class_name PlayerBullet

var SPEED = -100

func _process(delta):
	var velocity = Vector2(0, SPEED * delta)
	translate(velocity)
