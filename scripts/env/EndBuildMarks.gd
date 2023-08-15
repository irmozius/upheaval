extends Node3D

@onready var entity = $".."

var player : PlayerCharacter
var current_mark := 1
var level := 0.0

func _on_mark_1_body_entered(body):
	if body is PlayerCharacter:
		var keyring = body.get_node("KeyringComponent").keys
		var f = keyring.find("white key")
		if f != -1:
			player = body
			MusicManager.next_section.emit()

func _process(delta):
	if !player: return
	if current_mark == 6:
		MusicManager.danger = 0.0
		queue_free()
		return
	var m = get_child(current_mark)
	var ppos = player.global_position
	var dis = 100.0
	if ppos.distance_to(m.global_position) < 100:
		dis = ppos.distance_to(m.global_position)
	if dis < 10.0:
		current_mark += 1
	level = move_toward(level, current_mark, 0.02)
	MusicManager.danger = level
	
