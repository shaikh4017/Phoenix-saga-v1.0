extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 0.0


func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area.name)
