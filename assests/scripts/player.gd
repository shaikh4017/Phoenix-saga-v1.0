extends CharacterBody2D

# --- Health Bar ---
@onready var health_bar_scene = preload("res://assests/scenes/player_health_bar.tscn")
var health_bar: PlayerHealthBar

# --- Camera ---
@onready var camera: Camera2D = $Camera2D

# --- Movement ---
@export var fly_speed: float = 150.0   # adjusted for reasonable speed
@export var gravity: float = 10.0
@export var hover_damping: float = 5.0

# --- Health ---
@export var max_health: int = 10
var health: int
var can_take_damage: bool = true
@export var damage_cooldown: float = 1.0

# --- Scene change trigger ---
@export var scene_change_x: float = 1400

# --- Bullet ---
@export var bullet_scene: PackedScene = preload("res://assests/scenes/fireball.tscn")
var facing_right: bool = true

func _ready():
	add_to_group("player")

	# Initialize health
	health = max_health

	# Create health bar
	health_bar = health_bar_scene.instantiate()
	add_child(health_bar)
	health_bar.position = Vector2(0, -50)
	health_bar.set_max_health(max_health)
	health_bar.set_health(health)

func _physics_process(delta: float) -> void:
	# --- Horizontal movement ---
	velocity.x = 0.0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -fly_speed
		$AnimatedSprite2D.flip_h = true
		facing_right = false
	elif Input.is_action_pressed("ui_right"):
		velocity.x = fly_speed
		$AnimatedSprite2D.flip_h = false
		facing_right = true

	# --- Vertical movement ---
	if Input.is_action_pressed("ui_up"):
		velocity.y = -fly_speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = fly_speed
	else:
		velocity.y = lerp(velocity.y, 0.0, delta * hover_damping)

	# --- Apply gravity ---
	velocity.y += gravity * delta

	# --- Move the player ---
	move_and_slide()

	# --- Health bar stays above player ---
	if health_bar:
		health_bar.position = Vector2(0, -50)

	# --- Shooting ---
	if Input.is_action_just_pressed("ui_accept"):
		fire()

	# --- Scene change ---
	if global_position.x > scene_change_x:
		print("Player passed trigger X, switching to main_menu.tscn")
		get_tree().change_scene_to_file("res://assests/scenes/level_2.tscn")

func fire() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	# Fire in the direction player is facing
	if facing_right:
		bullet.dir = 0  # right
	else:
		bullet.dir = PI # left
	get_parent().add_child(bullet)

func _on_hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		take_damage(1)
	if body.is_in_group("boss"):
		take_damage(2)
	if body.is_in_group("boss_iceball"):
		take_damage(2)

func take_damage(amount: int = 1):
	if not can_take_damage:
		return

	health -= amount
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
