class_name SaveData extends Resource

@export var empty := true
@export var arsenal : Array[PackedScene]
@export var ammo := []
@export var keys : Array[String]
@export var checkpoint_list : Array[int]
@export var checkpoint : int
@export var current_song := "A_Pad"
@export var killed_enemies : Array[int]
@export var pickups : Array[int]
@export var doors : Array[int]
@export var hp : float
