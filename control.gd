extends Control
#var value = 0
@onready var score = $Score:
	set(x):
		score.text = "Total Exam: " + str(x)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
