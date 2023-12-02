extends Node2D

@onready var Wire:Line2D = get_node("Line2D")

func _activate():
	Wire.set_default_color(Color(0.65, 0, 0, 1))
	pass 

func _deactivate():
	Wire.set_default_color(Color(0.1, 0, 0, 1))
	pass 
