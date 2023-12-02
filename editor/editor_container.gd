extends Node

### Preload template scenes
var LevelParentScene = preload("res://editor/templates/level_parent.tscn")
var MechanicContainerScene = preload("res://editor/templates/mechanic_container.tscn")
var VischanicContainerScene = preload("res://editor/templates/vischanic_container.tscn")
var StructureContainerScene = preload("res://editor/templates/structure_container.tscn")
var DecorationContainerScene = preload("res://editor/templates/decoration_container.tscn")


func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_create_new_level("BigFactory")
			print("yep")
	pass

func _create_new_level(level_name):
	
	# Format name to include level prefix
	var formatted_name = "Level" + level_name
	
	# Create LevelParent node and configure it based on args
	var LevelParentNode = LevelParentScene.instantiate()
	add_child(LevelParentNode)
	LevelParentNode.set_name(formatted_name)
	
	# Get LevelParent node with formatted name
	var LevelParent = get_node(formatted_name)
	
	# Create level feature containers
	var MechanicContainerNode = MechanicContainerScene.instantiate()
	LevelParent.add_child(MechanicContainerNode)
	MechanicContainerNode.set_owner(LevelParent)
	
	var VischanicContainerNode = VischanicContainerScene.instantiate()
	LevelParent.add_child(VischanicContainerNode)
	VischanicContainerNode.set_owner(LevelParent)
	
	var StructureContainerNode = StructureContainerScene.instantiate()
	LevelParent.add_child(StructureContainerNode)
	StructureContainerNode.set_owner(LevelParent)
	
	var DecorationContainerNode = DecorationContainerScene.instantiate()
	LevelParent.add_child(DecorationContainerNode)
	DecorationContainerNode.set_owner(LevelParent)
	
	# Pack ParentNode tree and save to -> res://editor/output/level_{name}
	var PackedLevelParent = PackedScene.new()
	PackedLevelParent.pack(LevelParent)
	var OutputPath = "res://editor/output/" + String(formatted_name).to_snake_case() + ".tscn"
	ResourceSaver.save(PackedLevelParent, OutputPath)
	
	LevelParent.print_tree_pretty()
	pass
