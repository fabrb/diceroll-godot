extends Node

@onready var rollBtn: Button = $centerContainer/roll

func startRoll() -> void:
	rollBtn.disabled = true
	
func finishRoll() -> void:
	rollBtn.disabled = false
