extends Area2D

@onready var coin_sfx = preload("res://assests/sounds/coin.wav")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Only count if player touches
		print("+1 coin")

		# Increment coin count
		MusicManager.add_coin(1)

		# Play sound at the scene root so it doesn't get deleted
		var sfx_player = AudioStreamPlayer.new()
		sfx_player.stream = coin_sfx
		get_tree().current_scene.add_child(sfx_player)
		sfx_player.play()
		sfx_player.connect("finished", sfx_player.queue_free)

		# Remove the coin
		queue_free()
