extends StaticBody2D

# Get things that need to be got
@onready var InteractionArea0:Area2D = $InteractionArea0
@onready var Dynamic0:Sprite2D = $Dynamic0

## Static variables


## Dynamic Variables
@export var state:int = 0 # [0 = inactive, 1 = activating, 2 = active, 3 = deactivating]
var active:bool = false
var activate_targets:Array 

func _ready():
	pass # Replace with function body.

func _on_interaction(area):
	if area.is_in_group("interaction_hook"):
		if active:
			_deactivate()
		else:
			_activate()
	pass

func _activate():
	# Mark as active
	active = true
	
	# Disable Collision
	#$InteractionArea0.set_deferred("monitorable", false)
	#$InteractionArea0.set_deferred("monitoring", false)
	
	# Visual Indicator
	$Dynamic0.rotation_degrees = 90
	
	# Activate all hazard mechanics
	get_tree().call_group("logic_mechanic", "_activate")
	get_tree().call_group("special_wire", "_activate")
	
	pass

func _deactivate():
	# Mark as inactive
	active = false
	
	# Visual Indicator
	$Dynamic0.rotation_degrees = 0
	
	# Activate all hazard mechanics
	get_tree().call_group("logic_mechanic", "_deactivate")
	get_tree().call_group("special_wire", "_deactivate")
	
	pass

func _physics_process(delta):
	
	pass

###
# Below are functions abstracted from _physics_process() for code-readability.
###
