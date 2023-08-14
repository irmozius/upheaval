class_name AmmoPickup extends PickupResource

@export_enum("light", "medium", "heavy") var ammo_type := "light"
@export var amount := 50

var names_map := {
	"light": "bones",
	"medium": "sinew",
	"heavy": "meat"
}

func get_message():
	return str("got %s\n%s" % [amount, names_map[ammo_type]])
