extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var free = true
var weight = 100
@export var spawn_point1 = Vector2(-300, 0)
@export var spawn_point2 = Vector2(0, 0)
@export var spawn_point3 = Vector2(300, 0)

func _ready() -> void:
	randomize()
	var spawn_points = [spawn_point1, spawn_point2, spawn_point3]
	var x = randi() % 3
	position = spawn_points[x]

func _process(delta: float) -> void:
	pass

func makefree():
	free = true
	$CollisionShape2D.set_deferred("disabled", false)
	
func makeunfree():
	free = false
	$CollisionShape2D.set_deferred("disabled", true)
	
	get_node("destination").set_deferred("disabled", false)
	$destination.visible = true
	randomize()
	var x = randf_range(-200, 200)
	var y = randf_range(-200, 0)
	while (x > -40 and x < 40 and y < -80):
		x = randf_range(-200, 200)
		y = randf_range(-200, 0)
	$destination.position = Vector2(100, -100)
	print(x, "  ", y)

func _physics_process(delta: float) -> void:
	if !free:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
