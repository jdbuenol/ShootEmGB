extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#This executes every frame
func _physics_process(_delta):
	if Input.is_action_just_pressed("start"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://ShootEmGB.tscn")
