extends Control
class_name PlayerHealthBar

@export var max_health: int = 3
var current_health: int = 3

@onready var bar: TextureProgressBar = null

func _ready():
	bar = $TextureProgressBar
	# Make sure TextureProgressBar starts with correct max and current values
	bar.max_value = max_health
	bar.value = current_health

func set_health(health: int):
	current_health = clamp(health, 0, max_health)
	update_bar()

func set_max_health(health: int):
	max_health = health
	if bar:
		bar.max_value = max_health
	update_bar()

func update_bar():
	if bar:
		bar.value = current_health
