extends Node2D

const WIN_SCREEN : PackedScene = preload("res://winScreen/winScreen.tscn")

const ice_cream : Color = Color("fff6d3")

var current_level : int = 1
var score : int = 0
var win_score : int = 1000

#This executes at the start of the scene
func _ready():
	if current_level == 1:
		$CanvasLayer/Label.add_color_override("font_color", ice_cream)
	randomize()
	$ParallaxBackground/ParallaxLayer2/Sprite.rotation_degrees = int(rand_range(0, 360))
	$ParallaxBackground/ParallaxLayer3/Sprite.rotation_degrees = int(rand_range(0, 360))
	$ParallaxBackground/ParallaxLayer5/Sprite2.rotation_degrees = int(rand_range(0, 360))
	$ParallaxBackground/ParallaxLayer4/Sprite2.rotation_degrees = int(rand_range(0, 360))
	$ParallaxBackground/ParallaxLayer2/Sprite.position.y = int(rand_range(16, 128))
	$ParallaxBackground/ParallaxLayer3/Sprite.position.y = int(rand_range(16, 128))
	$ParallaxBackground/ParallaxLayer4/Sprite2.position.y = int(rand_range(16, 128))
	$ParallaxBackground/ParallaxLayer5/Sprite2.position.y = int(rand_range(16, 128))
	$ParallaxBackground/ParallaxLayer2/AnimationPlayer.play("starblink")
	$ParallaxBackground/ParallaxLayer4/AnimationPlayer2.play("starblink")
	$ParallaxBackground/ParallaxLayer3/AnimationPlayer.play("starblink")
	$ParallaxBackground/ParallaxLayer5/AnimationPlayer2.play("starblink")

#Check if you won
func check_score():
	$CanvasLayer/Label.text = str(score)
	if score >= 1000:
		for x in get_children():
			if x == $ParallaxBackground or x == $PowerOffTimer:
				pass
			else:
				x.queue_free()
		var win_screen : Control = WIN_SCREEN.instance()
		add_child(win_screen)

#This executes very frame
func _physics_process(_delta):
	if Input.is_action_just_pressed("power_off"):
		$PowerOffTimer.start()
	if Input.is_action_just_released("power_off"):
		$PowerOffTimer.stop()

#Keep ESC to quit game
func _on_PowerOffTimer_timeout():
	get_tree().quit()

#If player loses
func game_over():
	$AudioStreamPlayer.queue_free()

#bomb
func bomb():
	for x in get_children():
		if "enemy" in x.name:
			x.get_hurt()
