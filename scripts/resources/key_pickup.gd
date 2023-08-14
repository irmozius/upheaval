class_name KeyPickup extends PickupResource

@export var key := "keyname"

func get_message():
	return str("got %s" % key)
