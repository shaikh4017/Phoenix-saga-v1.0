extends Node2D

@onready var video = $VideoStreamPlayer

func _ready():
	
	video.expand = true
	video.visible = true
	video.play()
	video.finished.connect(_on_video_finished)
	

func _on_video_finished():
	get_tree().change_scene_to_file("res://assests/scenes/main_menu.tscn")
