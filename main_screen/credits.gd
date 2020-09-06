extends Control

#This executes every frame
func _physics_process(_delta):
	if Input.is_action_just_pressed("special_attack") or Input.is_action_just_pressed("basic_attack") or Input.is_action_just_pressed("start"):
		get_parent().current_screen = true
		get_parent().current_button = 0
		get_parent().update_button()
		queue_free()
