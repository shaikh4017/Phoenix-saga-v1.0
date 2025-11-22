extends Control
class_name PlayerHealthBar

var max_health: int = 10
var current_health: int = 10

@onready var bar: TextureProgressBar = $TextureProgressBar
@onready var tween := get_tree().create_tween()

func set_max_health(value: int):
	max_health = value
	bar.max_value = value
	bar.value = value  # start full

func set_health(value: int):
	value = clamp(value, 0, max_health)

	# Animate smoothly over 0.3 sec
	if tween:
		tween.kill()    # stop old animation

	tween = get_tree().create_tween()
	tween.tween_property(bar, "value", value, 0.3)

	current_health = value
