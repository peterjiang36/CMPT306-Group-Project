extends Node2D

@onready var examButton = $"UI/ExamPaper"
@onready var score = $"Score Label"
var increment_score = 0

var time_accumulator = 0.0  # Accumulate time to control increment speed
var increment_interval = 1.0

@onready var enemy1 = $"Enemy1"
@onready var enemy2 = $"Enemy2"
@onready var enemy3 = $"Enemy3"
@onready var enemies = [enemy1, enemy2, enemy3]
var move_speed = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str(increment_score)
	$"BG-Music".play()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time_accumulator += delta
	
	if time_accumulator >= increment_interval:
		increment_score += 1  # Increment the score
		score.text = str(increment_score)  # Update the score display
		time_accumulator = 0.0  # Reset the accumulator
	for enemy in enemies:
		move_enemy_toward_exam(enemy, delta)


func _on_exam_paper_pressed() -> void:
	$PaperPressSound.play()
	increment_score+=1
	score.text = str(increment_score)
	
	
func move_enemy_toward_exam(enemy: Sprite2D, delta: float) -> void:
	var exam_position = examButton.global_position
	print("Moving enemy: ", enemy.name)
	var direction = (exam_position - enemy.global_position).normalized()
	enemy.position += direction * move_speed * delta

	if enemy.global_position.distance_to(exam_position) < 10:
		print(enemy.name, " reached the exam icon.")
		enemy.queue_free()  # Remove the enemy from the scene
		enemies.erase(enemy)
		increment_score -= 1
		score.text = str(increment_score)
