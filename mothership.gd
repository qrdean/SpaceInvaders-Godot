extends Node2D
class_name Mothership

@export var SPEED = 60.0

signal mothership_died(player_kill: bool)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(SPEED * delta, 0)
	translate(velocity)

func _on_area_2d_area_entered(area):
	if area.is_in_group("bounds"):
		mothership_died.emit(false)
		self.queue_free()
	if area.is_in_group("bullet"):
		mothership_died.emit(true)
		area.queue_free()
		self.queue_free()
