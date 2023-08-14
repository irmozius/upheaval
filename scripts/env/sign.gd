extends MeshInstance3D

@onready var label_3d = $Label3D

@export var sign_text := ""

func _ready():
	label_3d.text = sign_text
