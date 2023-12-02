extends StaticBody2D

# Get things that need to be got
@onready var Dynamic0:Sprite2D = $Dynamic0

## Static variables
var COUNTDOWN_TIME:float = 1.0 # in seconds | Max of 3.9s
var MAX_ROTATION:float = 2*PI*(COUNTDOWN_TIME/-4.0)

## Dynamic Variables
@export var state:int = 0 # [0 = inactive, 1 = counting down, 2 = active]
var active:bool = false
var activate_targets:Array
@onready var time:float = COUNTDOWN_TIME # in seconds

func _ready():
	Dynamic0.rotation = MAX_ROTATION
	pass # Replace with function body.

func _reset_timer():
	Dynamic0.rotation = MAX_ROTATION
	state = 0
	# Deactivate all hazard mechanics
	get_tree().call_group("hazard_mechanic", "_deactivate")
	get_tree().call_group("wire_vischanic", "_deactivate")
	pass

func _timer_done():
	time = COUNTDOWN_TIME
	Dynamic0.rotation = 0
	if active:
		get_tree().call_group("hazard_mechanic", "_activate")
		get_tree().call_group("wire_vischanic", "_activate")
		state = 2
	else:
		_reset_timer()
	
	pass

func _activate():
	# Mark as active
	active = true
	
	# l'states
	if state == 0:
		state = 1
	
	pass

func _deactivate():
	# Mark as inactive
	active = false
	
	if state == 2:
		_reset_timer()
	
	pass

func _physics_process(delta):
	if state == 1 && time > 0:
		time -= delta
		clamp(time, 0.0, 3.9)
		Dynamic0.rotation = 2*PI*(time/-4.0)
	if time <= 0 && state == 1:
		_timer_done()
	pass

###
# Below are functions abstracted from _physics_process() for code-readability.
###
