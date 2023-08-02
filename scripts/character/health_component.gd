extends Node

@onready var entity = $".."

@export var hitbox : HitBox
@export var max_hp := 100.0

var hp := 100.0

signal died

func _ready():
	if hitbox:
		hitbox.hit.connect(take_damage)

func take_damage(dam : float):
	change_hp(-dam)

func change_hp(amnt : float):
	hp += amnt
	if hp <= 0.0:
		die()

func die():
	if entity is PlayerCharacter: get_tree().get_first_node_in_group("dead_screen").show()
	died.emit()
	entity.remove_pieces()
	entity.queue_free()
