extends Area3D

var zone

signal found_zone

func _process(_delta):
	var cols = get_overlapping_areas()
	if cols.size() > 0:
		if !zone:
			found_zone.emit()
		if zone != cols[0]:
			zone = cols[0]
