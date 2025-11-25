extends CharacterBody2D

# --- Speed of the iceball ---
@export var speed: float = 400.0

# --- Direction to move (set by boss when shooting) ---
var direction: Vector2 = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	# Move iceball in its direction
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)
	
	# If collided with something
	if collision:
		var hit = collision.get_collider()
		if hit:
			# Damage the player if hit
			if hit.is_in_group("player") and hit.has_method("take_damage"):
				hit.take_damage(1)
		
		# Destroy the iceball after hitting anything
		queue_free()
