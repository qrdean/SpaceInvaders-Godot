extends Label

var basetext = "Score: "

func _on_world_update_score_ui(score):
	text = basetext + str(score)
