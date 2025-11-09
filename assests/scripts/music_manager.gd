extends Node

@onready var player: AudioStreamPlayer = AudioStreamPlayer.new()
var music_enabled: bool = false

func _ready() -> void:
	add_child(player)
	player.stream = preload("res://assests/sounds/main_game.wav") # loop set in stream
	if music_enabled:
		player.play()

func set_music_enabled(enabled: bool) -> void:
	music_enabled = enabled
	if music_enabled:
		player.play()
	else:
		player.stop()
