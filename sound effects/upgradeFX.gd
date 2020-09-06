extends AudioStreamPlayer

func _on_Timer_timeout():
	queue_free()
