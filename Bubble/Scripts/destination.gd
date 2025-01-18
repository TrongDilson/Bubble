extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("disabled", true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# print(position.x, " ", position.y)
	pass


func _on_body_entered(body: Node2D) -> void:
	print("found")
	print(body.z_index)
	if body.z_index == 1 or body.z_index == 4:
		randomize()
		var x = randf_range(-200, 200)
		var y = randf_range(-200, 0)
		while (x > -40 and x < 40 and y < -80):
			x = randf_range(-200, 200)
			y = randf_range(-200, 0)
		position = Vector2(x, y)
		return
	body.removepackage(self.owner)
