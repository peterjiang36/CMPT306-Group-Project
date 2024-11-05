extends Node2D
class_name Player

var health: int = 100

# Preload the enemy scene to create instances
@onready var enemy_scene = preload("res://Enemy_Scene.tscn")

func _ready() -> void:
	# Ensure the mouse input is captured
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#func _input(event: InputEvent) -> void:
	## Check if the mouse button is pressed
	#if event is InputEventMouseButton and event.pressed:
		#pass

#func spawn_enemy(position: Vector2) -> void:
	## Instance an enemy and set its position
	#var enemy_instance = enemy_scene.instantiate()
	#add_child(enemy_instance)
	#enemy_instance.position = position
	#enemy_instance.start_timer()
	
func take_damage(amount:int) -> void:
	health -= amount
	if health <=0:
		queue_free()
