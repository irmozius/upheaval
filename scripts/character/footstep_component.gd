extends Node3D

@export var stride := 0.34

@onready var entity = $".."
@onready var snd = $step
@onready var motion = $"../MotionComponent"

var current_stride := 0.0

func step():
	snd.splay()

func _process(delta):
	if motion.moving:
		current_stride += delta
		if current_stride >= stride:
			step()
			current_stride = 0.0
	else:
		if current_stride != 0.0:
			current_stride = 0.0
