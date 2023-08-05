extends MeshInstance3D

@export_multiline var msg := ""
@export var s_colour : Color

@onready var label_3d = $Label3D

func set_colour(colour : Color):
	var mat : StandardMaterial3D = mesh.surface_get_material(0).duplicate()
	mat.emission = colour
	mat.albedo_color = colour
	mesh.surface_set_material(0, mat)
	
func set_text(text : String):
	label_3d.text = text
	
func _ready():
	set_colour(s_colour)
	set_text(msg)
