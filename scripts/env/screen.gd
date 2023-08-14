extends MeshInstance3D

@export_multiline var msg := ""
@export var s_colour : Color

@onready var label_3d = $Label3D
@onready var timer = $Timer

var characters := ["#", "/", "!", "'", "$", "%",
					"K", "Z", "Q", "W", "1", "7",
					":", ";", "<", ">"]
var real_text

func set_colour(colour : Color):
	var mat : StandardMaterial3D = mesh.surface_get_material(0).duplicate()
	mat.emission = colour
	mat.albedo_color = colour
	mesh.surface_set_material(0, mat)
	
func set_text(text : String):
	label_3d.text = text
	real_text = text

func override_text():
	var o_text : String
	for o in range(3):
		for i in range(randi_range(4,7)):
			o_text += characters.pick_random()
		o_text += "\n"
	label_3d.text = o_text
	
func _ready():
	set_colour(s_colour)
	set_text(msg)
	timer.start(randf_range(0.01,1.0))
	
func _on_timer_timeout():
	if label_3d.visible:
		label_3d.hide()
		timer.start(randf_range(0.01,0.1))
	else:
		if label_3d.text == real_text:
			if randf() > 0.5:
				override_text()
		else:
			if randf() > 0.1:
				set_text(real_text)
			else:
				override_text()
		label_3d.show()
		timer.start(randf_range(0.01,1.0))
	
