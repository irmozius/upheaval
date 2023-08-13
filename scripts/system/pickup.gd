class_name Pickup extends Area3D

@onready var snd = $snd

@export var r_name : String
@export var pickup_resource : PickupResource
@export var mesh : Node
@export var sound : AudioStream

var spin := true

func _ready():
	snd.stream = sound

func _on_area_entered(area):
	if area is PickupGrabComponent:
		spin = false
		snd.splay()
		get_parent().found_list.append(get_index())
		area.pickup(pickup_resource)
		queue_free()

func _process(delta):
	if spin:
		mesh.rotate_y(0.01)
