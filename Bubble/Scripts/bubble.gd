extends CharacterBody2D

@onready var joystick = $"../Camera2D/joystick"

var speed = 30
var weight = 500
var b = Array([], TYPE_OBJECT, "Node", null)
@export var max_surviving_time = 25
var remaining_time
var current_time
var previous_time = current_time
var totalscore = 0

func health() -> float:
	current_time = Time.get_unix_time_from_system()
	
	return remaining_time / max_surviving_time

func _ready() -> void:
	remaining_time = max_surviving_time
	previous_time = 0
	pass

func _process(delta: float) -> void:
	previous_time = current_time
	current_time = Time.get_unix_time_from_system()
	if delta < remaining_time:
		remaining_time -= delta
	else:
		remaining_time = 0
		queue_free()
	var t = self.owner
	t.get_node("score").text = "score: " + str(totalscore) 
	t.get_node("health").text = "health: " + str(ceil(health() * 100))
	# print(self.position.x, " ", self.position.y)

func addpackage(package) -> void:
	if b.count(package) == 0:
		b.append(package)
		weight += package.weight
		var t = package.get_node("package/Sprite2D")
		t.visible = not t.visible
	# need to add completepackage as child of Bubble
	
func removepackage(package):
	if b.count(package) == 0:
		return
	b.erase(package)
	weight -= package.weight
	totalscore += package.score()
	if remaining_time + 5 > max_surviving_time:
		remaining_time = max_surviving_time
	else:
		remaining_time += 5
	package.makefree()
	var t = package.get_node("package/Sprite2D")
	t.visible = not t.visible
	

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
