extends Control

func _ready():
	
	$Label.text = MusicManager.end_message
	$Label3.text = "Total Coins: %d" % MusicManager.coins
	#$ScoreLabel.text = "Score: %d" % MusicManager.score
	$Label2.text="Score: %d" %MusicManager.score
	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://assests/scenes/main_menu.tscn")
