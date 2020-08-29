extends Node2D

#This executes at the start of the scene
func _ready():
	$ParallaxBackground/ParallaxLayer2/AnimationPlayer.play("starblink")
	$ParallaxBackground/ParallaxLayer2/AnimationPlayer2.play("starblink")
	$ParallaxBackground/ParallaxLayer3/AnimationPlayer.play("starblink")
	$ParallaxBackground/ParallaxLayer3/AnimationPlayer2.play("starblink")
