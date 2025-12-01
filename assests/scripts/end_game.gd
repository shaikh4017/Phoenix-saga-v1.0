extends Control

func _ready():
	
	#$Label.text = "Total Coins: %d" % MusicManager.coins
	$Label3.text = "%s\nTotal Coins: %d" % [MusicManager.end_message, MusicManager.coins]
	#$ScoreLabel.text = "Score: %d" % MusicManager.score
	$Label2.text="Score: %d" %MusicManager.score
	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://assests/scenes/main_menu.tscn")
