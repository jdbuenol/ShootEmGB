extends KinematicBody2D

var speed : float = 0
var rng : int = 0
var hit_points : int = 2
var hitted : bool = false
var flashing : int = 0

const ENEMY_BULLET : PackedScene = preload("res://enemies/enemy_bullet.tscn")
const LASER_UPGRADE : PackedScene = preload("res://upgrades/laser_upgrade.tscn")
const SUPER_UPGRADE : PackedScene = preload("res://upgrades/super_upgrade.tscn")

var upgrades : Array = [LASER_UPGRADE, SUPER_UPGRADE]

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().current_level == 2:
		$Particles2D.process_material.set("color", Color("c23a73"))
	elif get_parent().current_level == 3:
		$Particles2D.process_material.set("color", Color("94e344"))
	elif get_parent().current_level == 4:
		$Particles2D.process_material.set("color", Color("24b3b3"))
	$Sprite.texture = load("res://assets/enemies/big_enemy_ship_" + str(get_parent().current_level) + ".png")
	$Sprite2.texture = load("res://assets/enemies/big_enemy_ship_death_" + str(get_parent().current_level) + ".png")
	randomize()
	speed = rand_range(1.3, 3)
	$Sprite2.visible = false
	$AnimationPlayer.play("default")

#This executes every frame
func _physics_process(_delta):
	if hitted:
		flashing += 1
		if flashing == 5:
			flashing = 0
			$Sprite.visible = !$Sprite.visible
	position.x += speed
	if rng == 1:
		position.y += speed / 3.0
	elif rng == 2:
		position.y -= speed / 3.0
	if position.y >= 130:
		position.y = 130
	elif position.y <= 14:
		position.y = 14

# this enemy die from 2 hits
func get_hurt():
	if !hitted:
		hit_points -= 1
		if hit_points <= 0:
			get_parent().score += 200
			get_parent().check_score()
			$Sprite2.visible = true
			$AnimationPlayer.queue_free()
			$Sprite.queue_free()
			$VisibilityNotifier2D.queue_free()
			$AttackTimer.queue_free()
			if rand_range(0, 1) > 0.5:
				call_deferred("drop_upgrade")
			$CollisionShape2D.queue_free()
			$Particles2D.queue_free()
			$AnimationPlayer2.play("death")
		else:
			hitted = true
			$hittedTimer.start()

# Queue free at end of death
func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()

#	Timer to when shoot
func _on_AttackTimer_timeout():
	var enemy_bullet : Area2D = ENEMY_BULLET.instance()
	get_parent().add_child(enemy_bullet)
	enemy_bullet.global_position = $Position2D.global_position

# Timer to when to change direction
func _on_directionTimer_timeout():
	rng = int(rand_range(0, 3))
	$directionTimer.start()

# Start attacking when screen entered
func _on_VisibilityNotifier2D_screen_entered():
	$AttackTimer.start()

# when to stop hitting
func _on_hittedTimer_timeout():
	hitted = false
	$Sprite.visible = true

# too much time in screen is dead
func _on_screenTimer_timeout():
	queue_free()

# Drops a laser upgrade or a bomb
func drop_upgrade():
	var upgrade : Area2D = upgrades[int(rand_range(0, upgrades.size()))].instance()
	get_parent().add_child(upgrade)
	upgrade.global_position = global_position
