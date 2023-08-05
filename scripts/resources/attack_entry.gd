class_name AttackEntry extends Resource

@export var attack_range := 5.0
@export_enum("Animation", "Weapon") var type := "Weapon"
@export var anim_name := ""
@export_enum("Light", "Heavy", "N/A") var weapon_attack_type := "Light"
@export var anim_cooldown := 0.2
