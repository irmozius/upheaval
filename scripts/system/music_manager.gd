extends Node

var danger := 0.0

var current_song := "A_Pad"
var current_player : meta_player

signal next_section
signal death
signal win
signal trans

var playing := false

func _ready():
	for song in get_children():
		song.trans.connect(transition)
	
func transition(song : meta_player):
	current_player = song
	current_song = song.name
	trans.emit()
