class_name WeaponPickup extends PickupResource

@export var weapon : PackedScene
@export var weapon_name := ""

func get_message():
	return str("found %s" % weapon_name)
