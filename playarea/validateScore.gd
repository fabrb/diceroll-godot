extends Node

var rollScore: int = 0

func rollStarted(numberOfDice: int) -> void:
	for nodesData in get_tree().get_nodes_in_group("tableUi"):
		nodesData.call("hideScore")

func setRollValue(value: int) -> void:
	for nodesData in get_tree().get_nodes_in_group("tableUi"):
		nodesData.call("updateRollScore", value)
		nodesData.call("showScore")
