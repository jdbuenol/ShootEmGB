extends Node2D

const WIN_SCREEN : PackedScene = preload("res://winScreen/winScreen.tscn")

var ice_cream : Color = Color("fff6d3")
var current_level : int = 1
var score : int = 0
var win_score : int = 1000
var current_stage : int = 1

#This executes at the start of the scene
func _ready():
	update_current_level()
	if current_level == 2:
		$AudioStreamPlayer.stream = load("res://music/stage-02.ogg")
	elif current_level == 3:
		$AudioStreamPlayer.stream = load("res://music/stage-03.ogg")
	elif current_level == 4:
		$AudioStreamPlayer.stream = load("res://music/endless-stage.ogg")
	$AudioStreamPlayer.play()
	win_score = current_level * 1000
	if current_level == 4:
		win_score = 1000
	else:
		$ship/spawnEnemy.wait_time = $ship/spawnEnemy.wait_time / current_level
	update_stars()
	ice_cream = Color("fff6d3") if current_level == 1 else Color("dad3af") if current_level == 2 else Color("e2f3e4") if current_level == 3 else Color("e2e6cf")
	$ParallaxBackground/ParallaxLayer/Sprite.texture = load("res://assets/background/bg_" + str(current_level) + ".png")
	$CanvasLayer/Label.add_color_override("font_color", ice_cream)
	$ship/CanvasLayer/Label.add_color_override("font_color", ice_cream)
	$ship.update_palette()
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
	if score >= win_score:
		if current_level < 4:
				for x in get_children():
					if x == $ParallaxBackground or x == $PowerOffTimer:
						pass
					else:
						x.queue_free()
				var win_screen : Control = WIN_SCREEN.instance()
				add_child(win_screen)
		else:
			current_stage += 1
			$ship/spawnEnemy.wait_time = $ship/spawnEnemy.wait_time * (current_stage - 1) / current_stage
			win_score += 1000 * current_stage

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
	for x in get_children():
		if x == $ParallaxBackground or x == $PowerOffTimer:
			pass
		else:
			x.queue_free()
	var lose_screen : Control = WIN_SCREEN.instance()
	lose_screen.fail()
	add_child(lose_screen)

#bomb
func bomb():
	for x in get_children():
		if "enemy" in x.name:
			if x.global_position.x > $ship.global_position.x:
				x.get_hurt()

#updates the current level
func update_current_level():
	var file : File = File.new()
	if not file.file_exists("user://current_level.save"):
		print("Error in file system: 01")
		queue_free()
# warning-ignore:return_value_discarded
	file.open("user://current_level.save", File.READ)
	current_level = int(file.get_line())

#updates stars to stage palette
func update_stars():
	if current_level >= 2:
		$ParallaxBackground/ParallaxLayer2/Sprite.texture = load("res://assets/background/star_1" + str(current_level) + ".png")
		$ParallaxBackground/ParallaxLayer4/Sprite2.texture = load("res://assets/background/star_1" + str(current_level) + ".png")
		$ParallaxBackground/ParallaxLayer3/Sprite.texture = load("res://assets/background/star_2" + str(current_level) + ".png")
		$ParallaxBackground/ParallaxLayer5/Sprite2.texture = load("res://assets/background/star_2" + str(current_level) + ".png")
