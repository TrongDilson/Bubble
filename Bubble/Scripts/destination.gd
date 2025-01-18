extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("disabled", true)
	randomize()
	var x = randf_range(0, 200)
	var y = randf_range(0, 200)
	
	position = Vector2(x, y)
	$CollisionShape2D.position = Vector2(x, y)
	print(x, "  ", y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
