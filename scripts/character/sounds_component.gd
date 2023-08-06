extends Node3D

@onready var btimer = $btimer
@onready var states = $"../states"


func start_barks():
	btimer.start(randf_range(2,4))

func stop_barks():
	btimer.stop()

func play_sound(type : String):
	get_node(type).splay()

func _on_btimer_timeout():
	play_sound("bark")
	btimer.start(randf_range(2,4))
