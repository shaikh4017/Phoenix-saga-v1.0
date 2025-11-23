extends CharacterBody2D

@export var speed: float = 400.0
var direction: Vector2 = Vector2.RIGHT  # must be normalized

func _ready():
	direction = direction.normalized()  # make sure it's a unit vector

func _physics_process(delta: float) -> void:
	# Move in the set direction
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)
	
	if collision:
		var collider = collision.get_collider()

		# Damage player
		if collider.is_in_group("player") and collider.has_method("take_damage"):
			collider.take_damage(1)

		# Damage boss (optional)
		if collider.is_in_group("boss") and collider.has_method("take_damage"):
			collider.take_damage(1)

		# Destroy iceball on collision
		queue_free()
