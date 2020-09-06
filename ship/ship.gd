extends KinematicBody2D

const SPEED : int = 60

const BULLET : PackedScene = preload("res://ship/bullet.tscn")
const ENEMY_SHIP : PackedScene = preload("res://enemies/enemy_ship.tscn")
const BIG_ENEMY_SHIP : PackedScene = preload("res://enemies/big_enemy_ship.tscn")
const ENEMY_ASTEROID : PackedScene = preload("res://enemies/enemy_asteroid.tscn")
const SHOOT_FX : PackedScene = preload("res://sound effects/shootFX.tscn")
const EXPLOSION_FX : PackedScene = preload("res://sound effects/explosionFX.tscn")
const DEAD_FX : PackedScene = preload("res://sound effects/deadFX.tscn")

var enemies : Array = [ENEMY_SHIP, BIG_ENEMY_SHIP, ENEMY_ASTEROID]
var velocity : Vector2 = Vector2()
var attack : bool = false
var triple_laser : bool = false
var super_counter : int = 0
var super_cooldown : bool = false
var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$dead_ship.visible = false
	randomize()
	$AnimationPlayer.play("default")

# This executes every frame
func _physics_process(_delta):
	
	velocity = Vector2()
	if !dead:
		if Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED * 1.2
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED * 1.2
		
		if Input.is_action_just_pressed("basic_attack"):
			if !attack:
				get_parent().add_child(SHOOT_FX.instance())
				if triple_laser:
					upgraded_attack()
				else:
					basic_attack()
	
		if Input.is_action_just_pressed("special_attack"):
			if !super_cooldown and super_counter > 0:
				get_parent().add_child(EXPLOSION_FX.instance())
				super_cooldown = true
				get_parent().bomb()
				super_counter -= 1
				$CanvasLayer/Label.text = str(super_counter)
				$superTimer.start()

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

#upgraded attack
func upgraded_attack():
	$AnimationPlayer2.play("attack")
	attack = true
	$AttackTimer.start()
	for x in range(0, 3):
		var bullet : Area2D = BULLET.instance()
		get_parent().add_child(bullet)
		bullet.global_position = $bullet.global_position
		bullet.global_position.y = bullet.global_position.y + 4 - 4*x

#Can attack again
func _on_AttackTimer_timeout():
	attack = false

#Spawn enemies every 3 seconds
func _on_spawnEnemy_timeout():
	var enemy : KinematicBody2D = enemies[int(rand_range(0, enemies.size()))].instance()
	get_parent().add_child(enemy)
	enemy.global_position = Vector2(global_position.x + 150, int(rand_range(20, 124)))
	$spawnEnemy.start() 

#Die
func get_hurt():
	get_parent().add_child(DEAD_FX.instance())
	$AnimationPlayer.queue_free()
	$AnimationPlayer2.queue_free()
	$CollisionShape2D.queue_free()
	$main_ship.queue_free()
	$fuel.queue_free()
	dead = true
	$dead_ship.visible = true
	$AnimationPlayer3.play("death")

#When get the laser upgrade
func upgrade_laser():
	triple_laser = true
	$TripleLaser.start()

#Laser upgrade time off
func _on_TripleLaser_timeout():
	triple_laser = false

#add one to the super counter
func get_super():
	super_counter += 1
	$CanvasLayer/Label.text = str(super_counter)

#Can use the super again
func _on_superTimer_timeout():
	super_cooldown = false

#update to the current palette
func update_palette():
	$main_ship.texture = load("assets/ship/ship_attack_" + str(get_parent().current_level) + ".png")
	$fuel.texture = load("assets/ship/ship_fuel_" + str(get_parent().current_level) + ".png")
	$dead_ship.texture = load("assets/ship/ship_death_" + str(get_parent().current_level) + ".png")
	$CanvasLayer/Sprite.texture = load("assets/upgrades/bomb_upgrade_" + str(get_parent().current_level) + ".png")

#Death
func _on_AnimationPlayer3_animation_finished(anim_name):
	if anim_name == "death":
		get_parent().game_over()
		queue_free()
