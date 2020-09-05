extends Control

var current_button : int = 0

const brown : Color = Color(124/255.0, 63/255.0, 88/255.0)
const strawberry : Color = Color(235/255.0, 107/255.0, 111/255.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_button()

#This executes every frame
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		current_button += 1
		if current_button > 3:
			current_button = 3
		update_button()
	elif Input.is_action_just_pressed("ui_up"):
		current_button -= 1
		if current_button < 0:
			current_button = 0
		update_button()

	if Input.is_action_just_pressed("start") or Input.is_action_just_pressed("basic_attack"):
		var current_level : File = File.new()
# warning-ignore:return_value_discarded
		current_level.open("user://current_level.save", File.WRITE)
		if current_button == 0:
			current_level.store_line("1")
		elif current_button == 1:
			current_level.store_line("2")
		elif current_button == 2:
			current_level.store_line("3")
		elif current_button == 3:
			current_level.store_line("4")
		current_level.close()
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://testing_scene.tscn")

	if Input.is_action_just_pressed("special_attack"):
		get_parent().current_screen = true
		get_parent().current_button = 0
		get_parent().update_button()
		queue_free()

#Update button
func update_button():
	if current_button == 0:
		show_button_1(true)
		show_button_2(false)
		show_button_3(false)
		show_button_4(false)
	elif current_button == 1:
		show_button_1(false)
		show_button_2(true)
		show_button_3(false)
		show_button_4(false)
	elif current_button == 2:
		show_button_1(false)
		show_button_2(false)
		show_button_3(true)
		show_button_4(false)
	elif current_button == 3:
		show_button_1(false)
		show_button_2(false)
		show_button_3(false)
		show_button_4(true)

#show/hide button 1:
func show_button_1(val : bool):
	$ColorRect2.visible = val
	$Label2.add_color_override("font_color", strawberry if val else brown)

#show/hide button 2:
func show_button_2(val : bool):
	$ColorRect3.visible = val
	$Label3.add_color_override("font_color", strawberry if val else brown)

#show/hide button 3:
func show_button_3(val : bool):
	$ColorRect4.visible = val
	$Label4.add_color_override("font_color", strawberry if val else brown)

#show/hide button 4:
func show_button_4(val : bool):
	$ColorRect5.visible = val
	$Label5.add_color_override("font_color", strawberry if val else brown)
