extends Control

var max_health: int = 3
var current_health: int = 3
@onready var bar = $TextureProgressBar

func _ready():
	update_bar()

func set_health(health: int):
	current_health = clamp(health, 0, max_health)
	update_bar()

func set_max_health(health: int):
	max_health = health
	bar.max_value = max_health
	update_bar()

func update_bar():
	bar.value = current_health
