extends Node2D

#var latest_chain_id = ""
#var chain_id_format = "chain_link{int}"

func _ready():
	#var hook = get_parent()
	#var link_count = hook.link_count
	# Catch for 2nd overall chain_link.
	#var latest_chain
	#if link_count == 1:
	#	latest_chain = get_parent()
		
	#else:
	#	latest_chain_id = chain_id_format.format({"int": str(link_count - 1)})
	#	latest_chain = hook.get_node(latest_chain_id)
	
	#print(latest_chain_id)
	#print(hook.get_children())
	
	# Set position of self to pinjoint on latest attached chain
	
	#position = latest_chain.get_node("pin_joint").global_position
	#print(position)
	#set_global_position(latest_chain.get_node("pin_joint").global_position)
	
	#print(latest_chain.get_node("pin_joint").position)
	
	# Attach self to latest attached chain
	#latest_chain.get_node("pin_joint").node_b = get_node("chain").get_path()
	#print(latest_chain.get_node("pin_joint").node_a)
	pass 
	
