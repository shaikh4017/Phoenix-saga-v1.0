extends Node

# --- Music Variables ---
@onready var player: AudioStreamPlayer = AudioStreamPlayer.new()
var music_enabled: bool = false

# --- Coin Variables ---
var coins: int = 0
signal coins_changed(new_count)

func _ready() -> void:
	add_child(player)
	player.stream = preload("res://assests/sounds/main_game.wav") # loop set in stream
	if music_enabled:
		player.play()

# --- Music Control ---
func set_music_enabled(enabled: bool) -> void:
	music_enabled = enabled
	if music_enabled:
		player.play()
	else:
		player.stop()

# --- Coins ---
func add_coin(amount: int = 1) -> void:
	coins += amount
	emit_signal("coins_changed", coins)

var score: int = 0
signal score_changed(new_score)

func add_score(amount: int = 1) -> void:
	score += amount
	emit_signal("score_changed", score)
