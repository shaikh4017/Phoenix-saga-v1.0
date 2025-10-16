extends CharacterBody2D

var dir: float = 0.0
var speed: float = 600.0

func _physics_process(delta: float) -> void:
	var motion = Vector2(speed, 0).rotated(dir) * delta
	var collision = move_and_collide(motion)

	if collision:
		var collider = collision.get_collider()
		print("Bullet hit: ", collider.name)
		
		if collider.is_in_group("enemies"):
			collider.queue_free()  # Kill enemy
			pass
		if collider.is_in_group("ground_enemy"):
			collider.take_damage(1)
			
		queue_free()
