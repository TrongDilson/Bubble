extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var free = true
var weight = 100

func _ready() -> void:
	
	
	pass

func makefree():
	free = true
	$CollisionShape2D.set_deferred("disabled", false)
	
func makeunfree():
	free = false
	$CollisionShape2D.set_deferred("disabled", true)
	$destination.set_deferred("disabled", false)
	$destination.visible = true

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
