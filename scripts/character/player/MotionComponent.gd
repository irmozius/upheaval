class_name MotionComponent extends Node3D

@export var speed := 9.0
@export var anim : Node
@export var steering : Node

@onready var entity = $".."
#@onready var anim = $"../AnimationComponent"
#@onready var steering_component = $"../SteeringComponent"

var velocity : Vector3
var moving := false

func move(direction : Vector3):
	if direction != Vector3.ZERO:
		moving = true
		var pos := global_position
		if steering:
			direction = steering.calculate_path(pos + direction)
		velocity = direction * speed
	else:
		moving = false
		if velocity.length() > 0.05:
			velocity.x = lerp(velocity.x, 0.0, 0.15)
			velocity.z = lerp(velocity.z, 0.0, 0.15)
		else:
			velocity.x = 0.0
			velocity.z = 0.0

func _physics_process(_delta):
	entity.velocity.x = velocity.x
	entity.velocity.z = velocity.z
	entity.move_and_slide()
