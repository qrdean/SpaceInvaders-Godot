extends Label

var basetext = "Lives: "

func _on_world_update_lives_ui(lives):
	text = basetext + str(lives)
