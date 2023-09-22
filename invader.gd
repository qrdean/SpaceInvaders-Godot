extends Node2D
class_name Invader

@export var bullet: PackedScene

signal hit_side()
signal spawn_bullet(gposition: Vector2, bullet: PackedScene)
signal invader_died()

func SpawnBullet():
	spawn_bullet.emit($bulletspawn.get_global_position(), bullet)

func _on_collision_area_area_entered(area):
	if area.is_in_group("bounds"):
		hit_side.emit()
	if area.is_in_group("bullet"):
		invader_died.emit()
		area.queue_free()
		self.queue_free()

