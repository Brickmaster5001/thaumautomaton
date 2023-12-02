extends Node2D

# Signals
signal length_reached

# Variables
var distance:float = 0.0
var max_distance:float = 600.0
var speed:int = 450
var velocity:Vector2
var max_link_distance:float = 5.0
var link_distance:float = 0.0
var link_count:int = 0
var new_link_id = ""
var old_link_id = ""
var old_chain_link
var new_chain_link

# Preload Scenes?
@onready var ImpactParticleScene = preload("res://scenes/particles/interact_hook_impact.tscn")

func _ready():
	# Get player node, get transformation for hook sprite, connect to recall_hook signal
	var Player = get_parent().get_node("Player")
	transform = Player.get_node("Hook").global_transform
	Player.recall_hook.connect(_on_recall_hook)
	pass

func _on_recall_hook():
	queue_free()
	pass

func _on_interaction(area):
	if area.is_in_group("input_mechanic_interaction_area"):
		_on_mechanic_interact()
	pass

func _on_mechanic_interact():
	var ImpactParticle = ImpactParticleScene.instantiate()
	get_parent().add_child(ImpactParticle)
	ImpactParticle.emitting = true
	ImpactParticle.position = self.position
	length_reached.emit()
	queue_free()	
	pass

func _physics_process(delta):
	if distance < max_distance:
		position += transform.x * speed * delta
		distance += speed * delta
		link_distance += speed * delta
	else:
		length_reached.emit()
		queue_free()
		
	pass

