extends Area2D

#When collide with the player
func _on_enemy_bullet_body_entered(body):
	if "ship" == body.name:
		body.get_hurt()

#queue free when bullet exits the scene
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
