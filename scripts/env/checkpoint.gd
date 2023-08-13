extends Node3D

var passed := false

@onready var pass_snd = $pass
@onready var area_3d = $Area3D

func _ready():
	if passed:
		queue_free()
	
func pass_checkpoint(player):
	pass_snd.play()
	SaveManager.save_data(player, self)
	
func _on_area_3d_body_entered(body):
	if passed: return
	if body is PlayerCharacter:
		passed = true
		pass_checkpoint(body)
