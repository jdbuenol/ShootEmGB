extends Area2D

#this executes every frame
func _physics_process(_delta):
	position.x += 1

#When the ship touches the upgrade
func _on_super_upgrade_body_entered(body):
	if body.name == "ship":
		body.get_super()
		queue_free()
