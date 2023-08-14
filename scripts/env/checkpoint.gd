extends Node3D

var passed := false

@onready var pass_snd = $pass
@onready var area_3d = $Area3D
@onready var messager = get_tree().get_first_node_in_group("message_label")

func _ready():
	if passed:
		queue_free()
	
func pass_checkpoint(player):
	get_parent().found_list.append(get_index())
	messager.display_message("checkpoint.\ngame saved.")
	pass_snd.play()
	SaveManager.save_data(player, self)
	
func _on_area_3d_body_entered(body):
	if passed: return
	if body is PlayerCharacter:
		passed = true
		pass_checkpoint(body)
