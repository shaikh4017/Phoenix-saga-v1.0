# Fireball.gd
extends CharacterBody2D

var dir: float = 0.0
var speed: float = 900.0

func _physics_process(delta: float) -> void:
	var motion = Vector2(speed, 0).rotated(dir) * delta
	var collision = move_and_collide(motion)
	if not collision:
		return

	var collider = collision.get_collider()
	print("Fireball hit:", collider.name)

	# Find the parent node with take_damage()
	var target = collider
	while target and not target.has_method("take_damage"):
		target = target.get_parent()

	# Apply damage if it's a valid enemy
	if target and (target.is_in_group("enemies") or target.is_in_group("ground_enemy")):
		target.take_damage(1)  # Let the enemy handle health
	if target and (target.is_in_group("boss") or target.is_in_group("ground_enemy")):
		target.take_damage(1)  # Let the enemy handle health
	# Fireball disappears after hitting
	queue_free()
