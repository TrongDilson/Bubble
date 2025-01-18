extends CharacterBody2D

@onready var joystick = $"../Camera2D/joystick"

var speed = 30

func _physics_process(delta):
	# Initialize direction based on joystick input
	var direction = joystick.posVector

	# Apply gravity only to the y-component of velocity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta  # Add gravity effect
	else:
		velocity.y = 0  # Reset vertical velocity if on the floor

	# Add directional movement based on joystick input
	if direction:
		velocity.x = direction.x * speed * 10
		velocity.y += direction.y * speed # Vertical movement from joystick input
	else:
		velocity.x = 0  # Stop horizontal movement when no input
	
	# Move the character with the calculated velocity
	move_and_slide()
