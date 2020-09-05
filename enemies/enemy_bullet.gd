extends Area2D

#This executes at the start of the scene
func _ready():
	$Sprite.texture = load("res://assets/bullets/enemy_bullet_" + str(get_parent().current_level) + ".png")

#When collide with the player
func _on_enemy_bullet_body_entered(body):
	if "ship" == body.name:
		body.get_hurt()

#queue free when bullet exits the scene
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#bullets will be destroyed
func get_hurt():
	queue_free()
