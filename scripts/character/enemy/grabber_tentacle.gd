extends Node3D

@export var left := true

func _ready():
	if !left:
		for i in $root.get_children():
			i.visible = !i.visible

func shoot():
	$AnimationPlayer.play("extend")
