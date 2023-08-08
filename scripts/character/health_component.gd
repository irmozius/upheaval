extends Node

@onready var entity = $".."


@export var hitbox : HitBox
@export var max_hp := 100.0
@export var sounds : Node
@export var tracker : Node

@onready var states = $"../states"
#@onready var sounds = $"../SoundsComponent"
#@onready var tracker = $"../TargetTrackerComponent"

var hp := 100.0

signal died

func _ready():
	if hitbox:
		hitbox.hit.connect(take_damage)

func take_damage(dam : float, _e):
	change_hp(-dam)

func change_hp(amnt : float):
	hp += amnt
	if hp <= 0.0:
		die()

func die():
	if tracker:
		MusicManager.danger -= tracker.danger_level
	if sounds:
		sounds.stop_barks()
	if !entity is PlayerCharacter:
		states.change_state("death")
	died.emit()
	entity.remove_pieces()
	if entity is PlayerCharacter:
		MusicManager.danger = 0.0
		get_tree().get_first_node_in_group("dead_screen").reveal()
		entity.queue_free()
