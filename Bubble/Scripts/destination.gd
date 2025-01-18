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
	body.removepackage(self.owner)
	pass
