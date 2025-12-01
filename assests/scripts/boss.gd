extends CharacterBody2D

@export var move_speed: float = 40.0
@export var max_health: int = 15
@export var shoot_interval: float = 2.0           # Boss shoots every 2 seconds
@export var iceball_scene: PackedScene = preload("res://assests/scenes/iceball.tscn")
@onready var health_bar_scene = preload("res://assests/scenes/health_bar.tscn")

var health: int
var player: Node2D
var health_bar: Control
var shoot_timer: Timer


func _ready() -> void:
	# Init health
	health = max_health

	# Get player from group
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

	# Add health bar
	health_bar = health_bar_scene.instantiate()
	add_child(health_bar)
	health_bar.position = Vector2(0, -100)
	health_bar.set_max_health(max_health)
	health_bar.set_health(health)

	# Add shoot timer
	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_interval
	shoot_timer.autostart = true
	shoot_timer.one_shot = false
	add_child(shoot_timer)
	shoot_timer.timeout.connect(_shoot_iceball)


func _physics_process(delta: float) -> void:
	if player:
		# Follow the player
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()

		# Flip boss sprite to face the player
		$AnimatedSprite2D.flip_h = player.global_position.x >= global_position.x

	# Keep health bar above boss
	if health_bar:
		health_bar.position = Vector2(0, 50)


func _shoot_iceball():
	if not player:
		return

	var iceball = iceball_scene.instantiate()
	get_parent().add_child(iceball)

	var dir = (player.global_position - global_position).normalized()
	iceball.direction = dir

	# Spawn outside boss collision
	var spawn_offset = dir * 50
	iceball.global_position = global_position + spawn_offset

	if not player:
		return
	
	iceball = iceball_scene.instantiate()
	get_parent().add_child(iceball)

	# Spawn iceball at boss position
	iceball.global_position = global_position

	# Send iceball toward player
	dir = (player.global_position - global_position).normalized()
	iceball.direction = dir


func take_damage(amount: int = 1) -> void:
	health -= amount

	if health_bar:
		health_bar.set_health(health)

	if health <= 0:
		die()

func die():
	MusicManager.end_message = "You WIN!!!"
	get_tree().change_scene_to_file("res://assests/scenes/end_game.tscn")
