extends Area2D

#this executes every frame
func _physics_process(_delta):
	position.x += 4

#Delete scene if outside the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_entered(body):
	if "enemy" in body.name:
		body.get_hurt()
		queue_free()
