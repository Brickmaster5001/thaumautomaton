extends CharacterBody2D

# Exported Variables
@export var SPEED:float = 500.0

# Non-Exported Variables
var has_hook:bool = true

# Signals
signal recall_hook

# Preload Scenes?
var InteractionHookScene = preload("res://scenes/interaction_hook.tscn")

func _ready():
	
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and has_hook == true:
			_fire_interaction_hook(event.position)
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and has_hook == false:
			_cancel_interaction_hook()
	pass
	

func _fire_interaction_hook(target):
	# Mark hook as fired.
	has_hook = false
	# Make on-player hook non-visible
	$Hook.hide()
	
	# Create instance of functional interaction hook scene
	var InteractionHook = InteractionHookScene.instantiate()
	get_parent().add_child(InteractionHook)
	InteractionHook.length_reached.connect(_on_hook_length_reached)
	pass

func _cancel_interaction_hook():
	# Reclaim hook.
	has_hook = true
	# Make on-player hook visible
	$Hook.show()
	# Recall actual hook
	recall_hook.emit()
	pass

func _on_hook_length_reached():
	_cancel_interaction_hook()
	pass

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x += direction_x * SPEED * delta
		velocity.x = clamp(velocity.x, -400.0, 400.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 3)
	
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y += direction_y * SPEED * delta
		velocity.y = clamp(velocity.y, -400.0, 400.0)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED * delta * 3)

	#var collision = move_and_collide(velocity * delta)
	move_and_slide()
	
	var angle_to_mouse = get_angle_to(get_global_mouse_position())
	$Core.rotation = angle_to_mouse
	$Hook.rotation = angle_to_mouse
	$BackRing.rotation = angle_to_mouse/4
