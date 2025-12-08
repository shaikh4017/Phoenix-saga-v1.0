extends Node2D

func _ready():
	$SkipButton.pressed.connect(_on_button_pressed)
	
func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://assests/UI/tutorial_ui.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assests/UI/tutorial_ui.tscn")
