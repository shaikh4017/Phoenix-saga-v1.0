extends Label

func _ready():
	text = "Score: %d" % MusicManager.score
	MusicManager.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int):
	text = "Score: %d" % new_score
