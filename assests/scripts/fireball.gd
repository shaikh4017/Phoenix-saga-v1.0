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

	## 1. Destroy spike on hit
	#if collider.is_in_group("spike"):
		#collider.queue_free()
		#queue_free()  # Fireball also disappears
		#return

	# 2. Search for parent that has take_damage() for enemies/bosses
	var target = collider
	while target and not target.has_method("take_damage"):
		target = target.get_parent()

	# 3. Damage enemy/boss
	if target and (target.is_in_group("enemies") or target.is_in_group("ground_enemy") or target.is_in_group("boss")):
		target.take_damage(1)
		MusicManager.add_score(1) 
	# 4. Fireball disappears after hitting something
	queue_free()
