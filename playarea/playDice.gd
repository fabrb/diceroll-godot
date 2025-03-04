extends Node3D

var dieScene: Node
var diceScenes: Array[Node]

@onready var centerPoint: Marker3D = $selectablePoint/center

func _on_roll_pressed() -> void:
	for nodesData in get_tree().get_nodes_in_group("tableData"):
		nodesData.call("rollStarted", len(diceScenes))
		
	for nodesData in get_tree().get_nodes_in_group("tableActions"):
		nodesData.call("startRoll")
	
	for nodesData in get_tree().get_nodes_in_group("die"):
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(nodesData.get_child(0), "scale", Vector3(0.01, 0.01, 0.01), 0.1)
		await get_tree().create_timer(0.1).timeout
		nodesData.free()
	
	dieScene = preload("res://props/d6.tscn").instantiate()
	add_child(dieScene)
	dieScene.global_transform.origin = centerPoint.global_transform.origin
	dieScene.global_transform.origin.z += 8
	
	diceScenes.append(dieScene)
	await update_dice_positions()
	for die in diceScenes:
		die.get_child(0).call("rollDie")
	
	diceScenes = []
	
func update_dice_positions() -> void:
	var count: int = len(diceScenes)
	
	for index in range(count):
		var die: Node = diceScenes[index]
		var vec3: Vector3 = Vector3(centerPoint.global_transform.origin.x, centerPoint.global_transform.origin.y, centerPoint.global_transform.origin.z)
		
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(die, "position", vec3, 0.1)
		await get_tree().create_timer(0.1).timeout
