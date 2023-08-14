extends Label

@onready var timer = $Timer

var fade := false

func display_message(mtext : String):
	fade = false
	text = mtext
	modulate.a = 1
	timer.start()

func _process(delta):
	if !fade: return
	if modulate.a > 0.01:
		modulate.a = lerp(modulate.a, 0.0, 0.05)
	else:
		fade = false
		modulate.a = 0.0

func _on_timer_timeout():
	fade = true
