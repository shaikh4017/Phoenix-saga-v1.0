extends CharacterBody2D

@export var bullet_scene: PackedScene = preload("res://assests/scenes/fireball.tscn") 

var fly_speed: float = 200.0
var gravity: float = 10.0
var hover_damping: float = 5.0

func _physics_process(delta: float) -> void:
	# Handle firing
	if Input.is_action_just_pressed("ui_accept"):
		fire()

	# Vertical movement
	if not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		velocity.y += gravity * delta

	if Input.is_action_pressed("ui_up"):
		velocity.y = -fly_speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = fly_speed
	else:
		velocity.y = lerp(velocity.y, 0.0, delta * hover_damping)

	# Horizontal movement
	velocity.x = 0.0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -fly_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = fly_speed

	move_and_slide()


func fire() -> void:
	var bullet = bullet_scene.instantiate()

	# Spawn from the current player position (or a child node like a muzzle)
	bullet.global_position = global_position
	bullet.dir = rotation  # Send current rotation
	get_parent().add_child(bullet)
func _ready() -> void:
	add_to_group("player")

	
