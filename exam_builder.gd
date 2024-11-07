extends Node2D

@onready var examButton = $"UI/Exam Paper"
@onready var score = $"Score Label"
var increment_score = 0

var time_accumulator = 0.0  # Accumulate time to control increment speed
var increment_interval = 1.0



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


func _on_exam_paper_pressed() -> void:
	$PaperPressSound.play()
	increment_score+=1
	score.text = str(increment_score)
