extends CharacterBody2D

@onready var health_bar_scene = preload("res://assests/scenes/player_health_bar.tscn")
var health_bar: PlayerHealthBar  # use correct type

# Movement variables
@export var fly_speed: float = 200.0
@export var gravity: float = 10.0
@export var hover_damping: float = 5.0

# Health
@export var max_health: int = 2
var health: int

# Optional invincibility
var can_take_damage: bool = true
@export var damage_cooldown: float = 1.0

# Bullet
@export var bullet_scene: PackedScene = preload("res://assests/scenes/fireball.tscn")

func _ready() -> void:
	add_to_group("player")
	health = max_health

	# Instantiate health bar as child of player
	health_bar = health_bar_scene.instantiate()
	add_child(health_bar)
	health_bar.position = Vector2(0, -25)  # 25 px above player
	health_bar.set_max_health(max_health)
	health_bar.set_health(health)

func _physics_process(delta: float) -> void:
	# Fire bullets
	if Input.is_action_just_pressed("ui_accept"):
		fire()

	# Keep health bar above player
	if health_bar:
		health_bar.position = Vector2(0, -50)

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
	bullet.global_position = global_position
	bullet.dir = rotation
	get_parent().add_child(bullet)

# Called when an enemy touches the player
func _on_hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		print("Enemy touched the player!")
		take_damage(1)

func take_damage(amount: int = 1):
	if not can_take_damage:
		return

	health -= amount
	print("Player health:", health)

	if health_bar:
		health_bar.set_health(health)

	can_take_damage = false
	await get_tree().create_timer(damage_cooldown).timeout
	can_take_damage = true

	if health <= 0:
		restart_game()

func restart_game():
	print("Player died! Restarting...")
	get_tree().reload_current_scene()
