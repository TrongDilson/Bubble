extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var free = true
var weight = 100
@export var spawn_point1 = Vector2(-300, 0)
@export var spawn_point2 = Vector2(0, 0)
@export var spawn_point3 = Vector2(300, 0)
@export var target_spawns = []
@export var max_score = 100
@export var time_delay_to_decay = 10
var remaining_time = time_delay_to_decay

func _ready() -> void:
	randomize()
	var spawn_points = [spawn_point1, spawn_point2, spawn_point3]
	var x = randi() % 3
	position = spawn_points[x]
	$destination.position = Vector2(0, 0)
	$package.set_deferred("disabled", false)
	$package.checked = false
	$destination.visible = false
	$package.visible = true
	remaining_time = time_delay_to_decay

func _process(delta: float) -> void:
	if delta < remaining_time:
		remaining_time -= delta
	else:
		remaining_time = 0	

func score() -> int:
	if remaining_time == 0:
		return 1
	return ceil(max_score * (remaining_time / time_delay_to_decay))

func makefree():
	free = true
	$CollisionShape2D.set_deferred("disabled", false)
	$destination.visible = false
	$package.visible = true
	_ready()
	
func makeunfree():
	free = false
	$CollisionShape2D.set_deferred("disabled", true)
	$package.visible = false
	get_node("destination").set_deferred("disabled", false)
	$destination.visible = true
	randomize()
	var i = randi() % target_spawns.size()
	var x = randf_range(-200, 200)
	var y = randf_range(-200, 0)
	while (x > -40 and x < 40 and y < -80):
		x = randf_range(-200, 200)
		y = randf_range(-200, 0)
	$destination.position = target_spawns[i] - position

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
