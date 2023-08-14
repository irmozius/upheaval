class_name Pickup extends Area3D

@onready var snd = $snd
@onready var messager = get_tree().get_first_node_in_group("message_label")
@export var r_name : String
@export var pickup_resource : PickupResource
@export var mesh : Node
@export var sound : AudioStream

var spin := true
var disabled = false

func _ready():
	snd.stream = sound

func _on_area_entered(area):
	if disabled: return
	if area is PickupGrabComponent:
		disable()
		spin = false
		snd.splay()
		messager.display_message(pickup_resource.get_message())
		get_parent().found_list.append(get_index())
		area.pickup(pickup_resource)

func _process(delta):
	if spin:
		mesh.rotate_y(0.01)

func disable():
	disabled = true
	hide()
	spin = false
