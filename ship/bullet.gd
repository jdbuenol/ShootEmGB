extends Area2D

#This executes at the start of the scene
func _ready():
	$Sprite.texture = load("res://assets/bullets/ship_bullet_" + str(get_parent().current_level) + ".png")

#this executes every frame
func _physics_process(_delta):
	position.x += 4

#Delete scene if outside the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#When hits an enemy
func _on_bullet_body_entered(body):
	if "enemy" in body.name:
		body.get_hurt()
		queue_free()
