class_name StateMachine extends Node

@onready var entity = $".."

@onready var state = get_node("idle")

func change_state(new_state : String):
	if new_state == state.name: return
#	if entity is EnemyCharacter:
#		print(new_state)
	state.exit()
	state = get_node(new_state)
	state.enter()
	
func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.p_update(delta)
