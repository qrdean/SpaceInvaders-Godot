extends Node2D

@export var SPEED = 30.0
@export var MOVE_DOWN = 10.0

signal spawn_bullet(gposition: Vector2, bullet: PackedScene)
signal invader_death()
signal all_invaders_dead()

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		if child is Invader:
			child.hit_side.connect(_reverse)
			child.spawn_bullet.connect(_spawn_bullet)
			child.invader_died.connect(_invader_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2(SPEED * delta, 0)
	translate(velocity)

func _reverse():
	SPEED = -SPEED
	translate(Vector2(0, MOVE_DOWN))
	
func _spawn_bullet(gposition: Vector2, bullet: PackedScene):
	spawn_bullet.emit(gposition, bullet)

func _on_enemy_timer_timeout():
	var children = get_children()
	if children.size() > 0:
		randomize()
		var random_child_id = randi()%children.size()
		var child = children[random_child_id]
		child.SpawnBullet()

func _invader_death():
	invader_death.emit()
	if get_children().size() == 1 || get_children().size() < 1:
		all_invaders_dead.emit()

