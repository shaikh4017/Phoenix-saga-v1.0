extends CharacterBody2D

@export var move_speed: float = 40.0
@export var max_health: int = 15
@onready var health_bar_scene = preload("res://assests/scenes/health_bar.tscn")

var health: int
var player: Node2D
var health_bar: Control

func _ready() -> void:
	# Initialize health
	health = max_health

	# Find player by group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

	# Add health bar
	health_bar = health_bar_scene.instantiate()
	add_child(health_bar)
	health_bar.position = Vector2(0, -100) # Boss is taller, adjust above
	health_bar.set_max_health(max_health)
	health_bar.set_health(health)

func _physics_process(delta: float) -> void:
	if player:
		# Move toward player
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

		# Flip sprite to face player
	if player.global_position.x < global_position.x:
		$AnimatedSprite2D.flip_h = false  # maybe change to false
	else:
		$AnimatedSprite2D.flip_h = true   # maybe change to true

	# Keep health bar above the boss
	if health_bar:
		health_bar.position = Vector2(0, 50)

func take_damage(amount: int = 1) -> void:
	health -= amount
	# Update health bar
	if health_bar:
		health_bar.set_health(health)

	if health <= 0:
		die()

func die() -> void:
	# Optional: play death animation here
	queue_free()
