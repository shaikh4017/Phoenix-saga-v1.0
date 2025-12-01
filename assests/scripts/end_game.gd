extends Control

func _ready():
	$Label.text = "THE END\nTotal Coins: %d" % MusicManager.coins

	await get_tree().create_timer(3.0).timeout

	get_tree().change_scene_to_file("res://assests/scenes/main_menu.tscn")
