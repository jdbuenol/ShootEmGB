extends Node2D

const WIN_SCREEN : PackedScene = preload("res://winScreen/winScreen.tscn")

var score : int = 0
var win_score : int = 1000

#This executes at the start of the scene
func _ready():
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
			if x == $ParallaxBackground:
				pass
			else:
				x.queue_free()
		var win_screen : Control = WIN_SCREEN.instance()
		add_child(win_screen)
