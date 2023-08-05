extends Node3D

@onready var entity = $".."
@onready var tracker = $"../TargetTrackerComponent"

@export var weapon : Node
@export var attacks : Array[AttackEntry]
@onready var timer = $Timer

var max_range : float
var can_anim := true

func _ready():
	set_max()
	
func set_max():
	var maxv := 0.0
	for a in attacks:
		if a.attack_range > maxv:
			maxv = a.attack_range
	max_range = maxv
	
func decide():
	var list := []
	var tdis : float = tracker.target_dis
	for attack in attacks:
		var value := 10.0
		var range_diff : float = abs(tdis - attack.attack_range)
		range_diff = clamp(range_diff, 1.0, 100.0)
		value -= (range_diff/5)
		if attack.attack_range < tdis:
			value = 0.0
		if attack.type == "Weapon":
			if !weapon.weapon.can_fire:
				value = 0.0
		else:
			if !can_anim:
				value = 0.0
		if value != 0.0:
			list.append({"attack": attack, "value": value, "name": attack.anim_name})
	list.sort_custom(sort_attacks)
	if list.size() == 0: return
#	print(str(list))
	var result : AttackEntry = list[0].attack
	if result.type == "Animation":
		can_anim = false
	return result

func sort_attacks(a, b) -> bool:
	return (a.value > b.value)

func _on_timer_timeout():
	can_anim = true
