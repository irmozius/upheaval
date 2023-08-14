class_name HealthPickup extends PickupResource

@export var hp_amount := 50.0

func get_message():
	return str("healed %s" % hp_amount)
