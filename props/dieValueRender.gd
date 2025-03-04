extends Node3D

func _ready() -> void:
	print(1)
	for die in get_tree().get_nodes_in_group("die"):
		if (die == self.get_parent().get_parent()):
			for value: Label3D in get_tree().get_nodes_in_group("dieValue"):
				if (value.get_parent().get_parent() == self):
					value.text = str(die.get_meta(value.name))
