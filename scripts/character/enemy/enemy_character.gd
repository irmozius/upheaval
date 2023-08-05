class_name EnemyCharacter extends CharacterBody3D

@onready var motion = $MotionComponent
@onready var rotator = $RotatorComponent
@onready var health = $HealthComponent
@onready var hit_box = $HitBoxComponent
@onready var detector = $AIDetectionComponent

func remove_pieces():
	motion.queue_free()
	rotator.queue_free()
	health.queue_free()
	hit_box.queue_free()
	detector.queue_free()
