extends Node

@onready var rollScore: Label = $centerContainer/gridContainer/rollScore
@onready var container: CenterContainer = $centerContainer

func _ready() -> void:
	rollScore.text = "0"
	container.visible = false

func updateRollScore(rollValue: int) -> void:
	rollScore.text = str(rollValue)
	
func hideScore() -> void:
	container.visible = false
	
func showScore() -> void:
	container.visible = true
