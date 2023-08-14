extends Node3D

@onready var light : SpotLight3D = $SpotLight3D
@onready var timer : Timer = $Timer
@onready var light_bar = $light_bar

var real_energy := 3.4

func _ready():
	timer.start(randf_range(1.0,3.0))

func override_energy():
	var energy =  randf_range(0.2, 2.0)
	light.light_energy = energy

func _on_timer_timeout():
	var off := (randf() > 0.6)
	if off:
		light.hide()
		light_bar.hide()
		timer.start(randf_range(0.01,0.1))
	else:
		if light.light_energy == real_energy:
			if randf() > 0.5:
				override_energy()
		else:
			if randf() > 0.1:
				light.light_energy = real_energy
			else:
				override_energy()
		light.show()
		light_bar.show()
		timer.start(randf_range(0.1,3.0))
