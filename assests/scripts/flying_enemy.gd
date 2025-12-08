extends CharacterBody2D

@export var move_speed: float = 40.0
@export var max_health: int = 3
#@onready var health_bar_scene = preload("res://assests/scenes/health_bar.tscn")

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
	#health_bar = health_bar_scene.instantiate()
	#add_child(health_bar)
	#health_bar.position = Vector2(0, 25) # 25 px above the enemy
	#health_bar.set_max_health(max_health)
	#health_bar.set_health(health)

func _physics_process(delta: float) -> void:
	# Move from right to left
	velocity = Vector2.LEFT * move_speed
	move_and_slide()

	# Keep health bar above the enemy
	if health_bar:
		health_bar.position = Vector2(0, 25)

func take_damage(amount: int = 1) -> void:
	health -= amount
	# Update bar
	if health_bar:
		health_bar.set_health(health)

	if health <= 0:
		die()

func die() -> void:
	queue_free()
