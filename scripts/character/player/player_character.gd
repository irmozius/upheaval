class_name PlayerCharacter extends CharacterBody3D

@onready var meshes = $meshes

@onready var motion = $MotionComponent
@onready var rotator = $RotatorComponent
@onready var health = $HealthComponent
@onready var hit_box = $HitBoxComponent

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	meshes.hide()

func remove_pieces():
	motion.queue_free()
	rotator.queue_free()
	health.queue_free()
	hit_box.queue_free()
