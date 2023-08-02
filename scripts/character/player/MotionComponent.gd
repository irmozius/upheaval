class_name MotionComponent extends Node3D

@onready var entity = $".."

@export var speed := 9.0

var velocity : Vector3

func move(direction : Vector3):
	if direction != Vector3.ZERO:
		velocity = direction * speed
#		velocity.x = direction.x * speed
#		velocity.z = direction.z * speed
	else:
		if velocity.length() > 0.05:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.z = lerp(velocity.z, 0.0, 0.1)
		else:
			velocity.x = 0.0
			velocity.z = 0.0

func _physics_process(_delta):
	entity.velocity.x = velocity.x
	entity.velocity.z = velocity.z
	entity.move_and_slide()
