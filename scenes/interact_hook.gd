extends Node2D

# Signals
signal length_reached

# Variables
var distance:float = 0.0
var max_distance:float = 600.0
var speed:int = 50
var velocity:Vector2
var max_link_distance:float = 25.0
var link_distance:float = 0.0
var link_count:int = 0
var new_link_id = ""
var old_link_id = ""
var old_chain_link
var new_chain_link

# Preload Scenes?
var chain_link = preload("res://scenes/chain_link.tscn")

func _ready():
	# Get player node, get transformation for hook sprite, connect to recall_hook signal
	var player = get_parent().get_node("player")
	transform = player.get_node("hook").global_transform
	player.recall_hook.connect(_on_recall_hook)
	print(get_node("pin_joint").global_position)
	print(position)
	pass

func _on_recall_hook():
	queue_free()
	pass

func _new_link():
	# Reset distance-till-next-link
	link_distance = 0.0
	
	# Count new link segment
	link_count += 1
	old_link_id = "chain_link%d" % (link_count - 1)
	new_link_id = "chain_link%d" % link_count
	print(link_count, old_link_id, new_link_id)
	
	# Create new chain_link segment
	var new_link = chain_link.instantiate()
	add_child(new_link)
	new_link.name = new_link_id
	new_chain_link = get_node(new_link_id)
	if link_count > 1:
		old_chain_link = get_node(old_link_id)
		print(old_chain_link)
		
	if link_count == 1:
		$pin_joint.node_b = new_chain_link.get_node("chain").get_path()
	else:
		#print(old_chain_link.get_node("chain").get_node("CollisionShape2D").shape.b)
		new_chain_link.position = old_chain_link.get_node("chain").get_node("CollisionShape2D").shape.b
		old_chain_link.get_node("pin_joint").position = old_chain_link.get_node("chain").get_node("CollisionShape2D").shape.b
		old_chain_link.get_node("pin_joint").node_b = new_chain_link.get_node("chain").get_path()
		#old_chain_link.get_node("pin_joint").node_b = new_chain_link.get_node("chain").get_path()
	# 
	
	
	pass

func _physics_process(delta):
	#var anchor = get_node("chain_anchor")
	#anchor.position = self.position
	#anchor.rotation = self.rotation 
	
	if distance < max_distance:
		position += transform.x * speed * delta
		distance += speed * delta
		link_distance += speed * delta
	else:
		length_reached.emit()
		queue_free()
	
	if link_distance >= max_link_distance:
		_new_link()
	pass

