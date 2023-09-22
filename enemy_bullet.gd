extends Area2D

var SPEED = 100

signal hit_player()

func _process(delta):
	var velocity = Vector2(0, SPEED * delta)
	translate(velocity)

func _on_body_entered(body):
	if body is Player:
		hit_player.emit()
		self.queue_free()


func _on_area_entered(area):
	if area is PlayerBullet:
		area.queue_free()
		self.queue_free()
