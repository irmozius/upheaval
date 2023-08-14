extends Node3D

@onready var btimer = $btimer
@onready var states = $"../states"

var disabled := false

func start_barks():
	if disabled: return
	btimer.start(randf_range(2,4))

func stop_barks():
	btimer.stop()

func play_sound(type : String):
	if disabled: return
	get_node(type).splay()

func _on_btimer_timeout():
	if disabled:
		stop_barks()
		return
	play_sound("bark")
	btimer.start(randf_range(2,4))
