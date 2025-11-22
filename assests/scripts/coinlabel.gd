extends Label

func _ready():
	# Initialize label text
	text = "Coins: %d" % MusicManager.coins

	# Connect the signal using a Callable
	MusicManager.coins_changed.connect(_on_coins_changed)

func _on_coins_changed(new_count: int):
	text = "Coins: %d" % new_count
