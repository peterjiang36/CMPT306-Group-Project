extends Node2D

@onready var hud = $UI/Control
@onready var clicker = $"UI/Exam Paper"


var score := 0:
	set(value):
		score = value
		hud.score = score
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score= 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
