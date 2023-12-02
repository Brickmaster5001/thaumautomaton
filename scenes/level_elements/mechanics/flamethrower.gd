extends StaticBody2D

# Get things that need to be got
@onready var HAZARD_COLLISION:CollisionShape2D = $HazardArea0.get_node("HazardCollision0")
@onready var HAZARD_RENDERER:Line2D = get_node("Line2D")

## Static variables
@export var MAX_HAZARD_LENGTH:float = 150.0
@export var HAZARD_SPEED_MODIFIER:float = 2.0
@export var HAZARD_DAMAGE:int = 2

## Dynamic Variables
@export var state:int = 0 # [0 = no fire, 1 = fire going on, 2 = fire on, 3 = fire going off]
var active:bool = false
var hazard_length:float = 0.0

func _ready():
	pass # Replace with function body.

func _activate():
	# Mark as active
	active = true
	
	if state == 0 || state == 3:
		state = 1
		$Dynamic0.rotation_degrees = -90
	pass

func _deactivate():
	# Mark as inactive
	active = false
	
	if state == 1 || state == 2:
		state = 3
		$Dynamic0.rotation_degrees = 0
	pass

func _physics_process(delta):
	
	# \/ Grows hazard collision length till it reaches MAX_HAZARD_LENGTH
	if state == 1:
		_hazard_grow(delta)
	# \/ Hazard loop while its collision length is MAX_HAZARD_LENGTH
	if state == 2:
		_hazard_run(delta)
	# \/ Shrinks hazard collision length till it reaches 0
	if state == 3:
		_hazard_shrink(delta)
	
	pass

###
# Below are functions abstracted from _physics_process() for code-readability.
###

func _hazard_grow(delta):
	# Put better comment here :D
	hazard_length += 300 * delta * HAZARD_SPEED_MODIFIER
	
	# Resizes and shifts the collision area
	HAZARD_COLLISION.shape.extents.y = floor(hazard_length)
	HAZARD_COLLISION.position.y = floor(hazard_length)/2
	
	HAZARD_RENDERER.set_point_position(1, Vector2(0, HAZARD_COLLISION.shape.extents.y))
	
	if hazard_length >= MAX_HAZARD_LENGTH: 
		state = 2
	
	#print("hazard_length: ", hazard_length, " length: ", HAZARD_COLLISION.shape.extents.y, " position: ", HAZARD_COLLISION.position.y)
	pass

func _hazard_run(delta):
	
	pass

func _hazard_shrink(delta):
	# Put better comment here :D
	hazard_length -= 300 * delta * HAZARD_SPEED_MODIFIER
	
	# Resizes and shifts the collision area
	HAZARD_COLLISION.shape.extents.y = floor(hazard_length)
	HAZARD_COLLISION.position.y = floor(hazard_length)/2
	
	HAZARD_RENDERER.set_point_position(1, Vector2(0, HAZARD_COLLISION.shape.extents.y))
	
	if hazard_length <= 0: 
		state = 0
	pass
