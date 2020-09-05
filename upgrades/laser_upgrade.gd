extends Area2D

#this executes at the start of the scene
func _ready():
	$Sprite.texture = load("res://assets/upgrades/laser_upgrade_" + str(get_parent().current_level) + ".png")

#this executes every frame
func _physics_process(_delta):
	position.x += 1

#When the ship get the upgrade
func _on_laser_upgrade_body_entered(body):
	if body.name == "ship":
		body.upgrade_laser()
		queue_free()
