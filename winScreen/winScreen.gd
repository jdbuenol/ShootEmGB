extends Control

var text_color : Color = Color("7c3f58")

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().current_level == 2:
		text_color = Color("2c1e74")
	elif get_parent().current_level == 3:
		text_color = Color("332c50")
	elif get_parent().current_level == 4:
		text_color = Color("1f084d")
	$Label.add_color_override("font_color", text_color)

#This executes every frame
func _physics_process(_delta):
	if Input.is_action_just_pressed("start"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://ShootEmGB.tscn")

#if lose
func fail():
	$AudioStreamPlayer.stream = load("res://music/fail_song.wav")
	$AudioStreamPlayer.play()
	$Label.text = "YOU LOSE!\n PRESS START TO\n CONTINUE"
