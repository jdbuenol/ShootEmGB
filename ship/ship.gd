extends KinematicBody2D

const SPEED : int = 50

const BULLET : PackedScene = preload("res://ship/bullet.tscn")
const ENEMY_SHIP : PackedScene = preload("res://enemies/enemy_ship.tscn")

var velocity : Vector2 = Vector2()
var attack : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimationPlayer.play("default")

# This executes every frame
func _physics_process(_delta):
	#PowerOff check
	if Input.is_action_just_pressed("power_off"):
		$PowerOffTimer.start()
	if Input.is_action_just_released("power_off"):
		$PowerOffTimer.stop()
	
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	
	if Input.is_action_just_pressed("basic_attack"):
		if !attack:
			basic_attack()
	velocity.x = SPEED * 2
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	if get_slide_count() > 0:
		for x in get_slide_count():
			if "enemy" in get_slide_collision(x).collider.name:
				get_hurt()

	if position.y < 7:
		position.y = 7
	if position.y > 137:
		position.y = 137

#Basic attack
func basic_attack():
	$AnimationPlayer2.play("attack")
	attack = true
	$AttackTimer.start()
	var bullet : Area2D = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.global_position = $bullet.global_position

#Power off the GameBoy
func _on_PowerOffTimer_timeout():
	get_tree().quit()

#Can attack again
func _on_AttackTimer_timeout():
	attack = false

#Spawn enemies every 5 seconds
func _on_spawnEnemy_timeout():
	var enemy_ship : KinematicBody2D = ENEMY_SHIP.instance()
	get_parent().add_child(enemy_ship)
	enemy_ship.global_position = global_position
	enemy_ship.global_position.x += 200
	enemy_ship.global_position.y = int(rand_range(20, 124))
	$spawnEnemy.start()

#Die
func get_hurt():
	queue_free()
