extends Node


func pause_node (node: Node): _set_node_process_state(node, false);
func unpause_node (node: Node): _set_node_process_state(node, true);
func _set_node_process_state (node: Node, should_process: bool):
	if node.has_method("pause") and not should_process:
		node.pause();
	
	if node.has_method("play") and should_process:
		node.play();

	node.set_process(should_process)
	node.set_physics_process(should_process)
	node.set_process_input(should_process)
	node.set_process_internal(should_process)
	node.set_process_unhandled_input(should_process)
	node.set_process_unhandled_key_input(should_process)
	


func pause_children (node: Node): _set_branch_process_state(node, false);
func unpause_children (node: Node): _set_branch_process_state(node, true);
func _set_children_process_mode (node: Node, should_process: bool):
	for child_node in node.get_children():
		_set_branch_process_state(child_node, should_process)


func pause_branch (node: Node): _set_branch_process_state(node, false);
func unpause_branch (node: Node): _set_branch_process_state(node, true);
func _set_branch_process_state(node: Node, should_process: bool):
	_set_node_process_state(node, should_process);
	_set_children_process_mode(node, should_process);
