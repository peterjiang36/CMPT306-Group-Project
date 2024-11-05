extends Node2D

@onready var player = $Player
@onready var enemy = []
@onready var enemy_scene = preload("res://Enemy_Scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	spaw_enemy(Vector2(350,400))
	spaw_enemy(Vector2(550,400))
	spaw_enemy(Vector2(750,400))

	
func _input(event: InputEvent) -> void:
	# Check if the mouse button is pressed
	if event is InputEventMouseButton and event.pressed:
		print("gooo")
		print(enemy.size())
		random_enemy_start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spaw_enemy(position: Vector2)-> void:
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)
	enemy_instance.position = position
	enemy.append(enemy_instance)
	print("spawing")
	
func random_enemy_start_timer() -> void:
	if enemy.size() > 0:
		# Randomly pick one of the enemies
		var random_index = randi() % enemy.size()
		var chosen_enemy = enemy[random_index]
		print("Timer assigned to enemy at position:", chosen_enemy.position)
		# Start the timer on the chosen enemy
		chosen_enemy.start_timer()
		
