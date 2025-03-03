extends RigidBody3D

var isActive: bool = true
var isMoving: bool = false
var isAboveMinVelocity: bool = false
var isOnGround: bool = false
var applyGravity: bool = false

var faces: Array[Marker3D] = []
var values: Array[Label3D] = []

func _ready() -> void:
	for face in get_tree().get_nodes_in_group("face"):
		if (face.get_parent().get_parent().get_parent() == self):
			faces.append(face)
		
	for value in get_tree().get_nodes_in_group("dieValue"):
		if (value.get_parent().get_parent().get_parent() == self):
			values.append(value)
			
func _physics_process(delta: float) -> void:
	if not isActive:
		return
	
	isAboveMinVelocity = linear_velocity.length() >= 0.001
	
	if (isMoving and not isAboveMinVelocity and isOnGround):
		isActive = false
		isMoving = false
		
		for nodesData in get_tree().get_nodes_in_group("tableData"):
			nodesData.call("setRollValue", int(String(findFaceSelected().text)))
		
		for nodesData in get_tree().get_nodes_in_group("tableActions"):
			nodesData.call("finishRoll")
		
	elif (not isMoving and isAboveMinVelocity):
		isMoving = true

func rollDie() -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	
	self.apply_impulse(Vector3.UP * rng.randf_range(10, 11))
	self.apply_impulse(Vector3.LEFT * rng.randf_range(-1.6, 1.6))
	self.apply_impulse(Vector3.BACK * rng.randf_range(-1.6, 1.6))
	
	self.apply_torque(Vector3(rng.randi_range(-100, 100), rng.randi_range(-100, 100), rng.randi_range(-100, 100)))

func findFaceSelected() -> Label3D:
	var bestValue: float = -1
	var bestFace: Node = null
	
	for face in faces:
		var pos: float = (face.global_transform.origin - global_transform.origin).dot(Vector3.UP)
		print(face.name, face.global_transform.origin - global_transform.origin)
		
		if (pos > bestValue):
			bestValue = pos
			bestFace = face
	
	for value in values:
		if (value.name == bestFace.name):
			return value
			
	return null

func _on_body_entered(body: Node) -> void:
	for group in body.get_groups():
		if (group.get_basename() == "table"):
			isOnGround = true
			return

func _on_body_exited(body: Node) -> void:
	for group in body.get_groups():
		if (group.get_basename() == "table"):
			isOnGround = false
			return
