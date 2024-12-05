extends Node2D

@onready var examButton = $"UI/ExamPaper"
@onready var score = $"Score Label"
@onready var total = $"Total"
@onready var enemy1_scene = preload("res://enemy_1.tscn")  # Ensure the correct path
@onready var enemy2_scene = preload("res://enemy_2.tscn")  # Ensure the correct path
@onready var enemy3_scene = preload("res://enemy_3.tscn")  # Ensure the correct path
@onready var game_over_label = $"GameOverLabel"
@onready var dark_overlay = $"DarkOverlay"
@onready var bg_music = $"BG-Music"
@onready var retry_button = $"Retry" 
@onready var start_button = $"StartButton"
@onready var Tutorial = $Tutorial

var increment_score = 0
var time_accumulator = 0.0
var increment_interval = 1.0
var move_speed = 50
var increment_rate = 1
var exam_Increase_Rate = 1
var exam_stealing_Rate = 10


var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hide_gameplay()
	
	score.text = str(increment_score)
	
	
	start_button.visible = true
	dark_overlay.visible = false  # Ensure the overlay is hidden initially
	game_over_label.visible = false
	retry_button.visible = false

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_accumulator += delta

	if time_accumulator >= increment_interval:
		increment_score += increment_rate
		score.text = str(increment_score)
		time_accumulator = 0.0
		


	for enemy in enemies:
		move_enemy_toward_exam(enemy, delta)
		
	if increment_score < 0:
		game_over()
		increment_score = 1
		score.text = str(increment_score)
		
		
		

# Increment score when the exam paper button is pressed
func _on_exam_paper_pressed() -> void:
	$"PaperPressSound".play()
	increment_score += exam_Increase_Rate
	score.text = str(increment_score)
	
func _on_surprise_pressed() -> void:
	$Surprise.play()
	increment_score -= randi_range(-100.0,100.0)
	
	score.text = str(increment_score)


# Spawn enemies at random positions
func spawn_enemy1() -> void:
	print("Spawning enemy1...")
	var enemy1_instance = enemy1_scene.instantiate()
	if enemy1_instance:
		add_child(enemy1_instance)
		enemies.append(enemy1_instance)
		#enemy1_instance.connect("clicked", Callable(self, "_on_enemy_clicked"))
		# Set enemy's position to a random location outside the screen
		var screen_size = get_viewport().get_visible_rect().size
		var spawn_position = Vector2(
			randf_range(-50, screen_size.x + 50),  # Spawn near or outside screen edges
			randf_range(-50, screen_size.y + 50)
		)
		enemy1_instance.global_position = spawn_position
		#print("Enemy spawned at: ", spawn_position)
	else:
		print("Failed to instance enemy!")
		
func spawn_enemy2() -> void:
	print("Spawning enemy2...")
	var enemy2_instance = enemy2_scene.instantiate()

		
	if enemy2_instance:
		add_child(enemy2_instance)
		enemies.append(enemy2_instance)

		# Set enemy's position to a random location outside the screen
		var screen_size = get_viewport().get_visible_rect().size
		var spawn_position = Vector2(
			randf_range(-50, screen_size.x + 50),  # Spawn near or outside screen edges
			randf_range(-50, screen_size.y + 50)
		)
		enemy2_instance.global_position = spawn_position
		#print("Enemy spawned at: ", spawn_position)
	else:
		print("Failed to instance enemy!")
		
		
		
func spawn_enemy3() -> void:
	print("Spawning enemy3...")
	var enemy3_instance = enemy3_scene.instantiate()

		
	if enemy3_instance:
		add_child(enemy3_instance)
		enemies.append(enemy3_instance)

		# Set enemy's position to a random location outside the screen
		var screen_size = get_viewport().get_visible_rect().size
		var spawn_position = Vector2(
			randf_range(-50, screen_size.x + 50),  # Spawn near or outside screen edges
			randf_range(-50, screen_size.y + 50)
		)
		enemy3_instance.global_position = spawn_position
		#print("Enemy spawned at: ", spawn_position)
	else:
		print("Failed to instance enemy!")

# Move an enemy toward the exam paper
func move_enemy_toward_exam(enemy: Node2D, delta: float) -> void:
	var exam_position = examButton.global_position
	var direction = (exam_position - enemy.global_position).normalized()
	enemy.position += direction * move_speed * delta * randf_range(0.0,2.0)
	#print("Enemy ", enemy.name, " moving to: ", exam_position, " Current position: ", enemy.global_position)

	# If the enemy reaches the exam paper
	if enemy.global_position.distance_to(exam_position) < 10:
		#print("Enemy ", enemy.name, " reached the exam paper!")
		enemy.queue_free()
		enemies.erase(enemy)
		$enemy_Touch_Paper.play()
		increment_score -= exam_stealing_Rate
		score.text = str(increment_score)
		
func game_over() -> void:
	$Game_Over.play()
	print("Game Over! Score is below 0.")
	#get_tree().paused = true  # Pause the game

	for timer in get_children():
		if timer is Timer:
			timer.stop()
		
	game_over_label.visible = true
	dark_overlay.visible = true
	retry_button.visible = true
	


	
func _on_start_button_pressed() -> void:
	print("Start button pressed. Starting game...")
	# Hide the start button
	bg_music.play()
	start_button.visible = false
	increment_score = 0
	score.text = str(increment_score)


	# Show gameplay elements and initialize the game
	show_gameplay()

	# Start background music
	bg_music.play()	
	
func show_gameplay() -> void:
	score.visible = true
	total.visible = true
	Tutorial.visible = false
	
	# Start a timer to spawn enemies
	var enemy1_spawn_timer = Timer.new()
	var enemy2_spawn_timer = Timer.new()
	var enemy3_spawn_timer = Timer.new()
#	enemy 1
	add_child(enemy1_spawn_timer)
	print("Timer added to scene!")
	enemy1_spawn_timer.wait_time = 5.0  # Time interval between spawns
	enemy1_spawn_timer.autostart = true
	enemy1_spawn_timer.one_shot = false
	enemy1_spawn_timer.timeout.connect(Callable(self, "spawn_enemy1"))
	enemy1_spawn_timer.start()
	#	enemy 2
	add_child(enemy2_spawn_timer)
	enemy2_spawn_timer.wait_time = 10.0  # Time interval between spawns
	enemy2_spawn_timer.autostart = true
	enemy2_spawn_timer.one_shot = false
	enemy2_spawn_timer.timeout.connect(Callable(self, "spawn_enemy2"))
	enemy2_spawn_timer.start()
	
	#	enemy 3
	add_child(enemy3_spawn_timer)
	enemy3_spawn_timer.wait_time = 20.0  # Time interval between spawns
	enemy3_spawn_timer.autostart = true
	enemy3_spawn_timer.one_shot = false
	enemy3_spawn_timer.timeout.connect(Callable(self, "spawn_enemy3"))
	enemy3_spawn_timer.start()
	
	print("Enemy spawn timer started!")

func hide_gameplay() -> void:
	score.visible = false
	dark_overlay.visible = false
	game_over_label.visible = false
	retry_button.visible = false
	total.visible = false
	Tutorial.visible  = true

func _on_retry_button_pressed() -> void:
	print("Retry button pressed. Restarting game...")
	#get_tree().paused = false  # Unpause the game
	get_tree().reload_current_scene()


func _on_upgrade_1_pressed() -> void:
	$NormalUpgrade.play()
	increment_score -= 50
	increment_rate += 1
	exam_Increase_Rate += 1
	move_speed += 40
	exam_stealing_Rate += 15
	score.text = str(increment_score)


func _on_upgrade_2_pressed() -> void:
	$NormalUpgrade.play()
	increment_score -= 200
	increment_rate += 5
	exam_Increase_Rate += 5
	move_speed += 30
	exam_stealing_Rate += 30
	score.text = str(increment_score)

func _on_upgrade_3_pressed() -> void:

	$Final_Upgrade.play()
	increment_score -= 500
	increment_rate += 30
	exam_Increase_Rate += 20
	move_speed += 50
	exam_stealing_Rate *= 2
	score.text = str(increment_score)
