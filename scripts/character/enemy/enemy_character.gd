class_name EnemyCharacter extends CharacterBody3D

@onready var motion = $MotionComponent
@onready var rotator = $RotatorComponent
@onready var health = $HealthComponent
@onready var hit_box = $HitBoxComponent
@onready var detector = $AIDetectionComponent
@onready var shape = $CollisionShape3D

func remove_pieces():
	hit_box.queue_free()
	detector.queue_free()
	health.queue_free()
	motion.queue_free()
	rotator.queue_free()
	shape.queue_free()

func create_corpse():
	remove_pieces()
	$SoundsComponent.disabled = true
	$AnimationComponent.play("death")
