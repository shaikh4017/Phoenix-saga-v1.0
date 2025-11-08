extends Control

signal tutorial_finished

@export var duration: float = 6.0

func _ready() -> void:
	show_tutorial()

func show_tutorial() -> void:
	visible = true
	await get_tree().create_timer(duration).timeout
	hide_tutorial()

func hide_tutorial() -> void:
	visible = false
	emit_signal("tutorial_finished")
