extends Area2D

const UPGRADE_FX : PackedScene = preload("res://sound effects/upgradeFX.tscn")

#This executes at the start of the scene:
func _ready():
	$Sprite.texture = load("res://assets/upgrades/bomb_upgrade_" + str(get_parent().current_level) + ".png")

#this executes every frame
func _physics_process(_delta):
	position.x += 1

#When the ship touches the upgrade
func _on_super_upgrade_body_entered(body):
	if body.name == "ship":
		get_parent().add_child(UPGRADE_FX.instance())
		body.get_super()
		queue_free()
