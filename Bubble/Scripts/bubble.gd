extends CharacterBody2D

@onready var joystick = $"../Camera2D/joystick"
@onready var anim_player = $AnimatedSprite2D

var speed = 30

# Reference to the current state
var current_state: State

func _ready():
	# Start in the Idle state
	set_state(idle_state.new(self))

func set_state(new_state: State):
	if current_state:
		current_state.Exit()  # Exit the current state
	current_state = new_state
	current_state.Enter()  # Enter the new state

func _physics_process(delta):
	# Let the current state handle updates
	if current_state:
		current_state.Update(delta)
