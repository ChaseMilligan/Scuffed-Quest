extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 275
const JUMP_HEIGHT = -625

var motion = Vector2()
var grabState = false
var grabDirection = ''
var attacking = false
var attackType = 0

func _physics_process(delta):
	motion.y += GRAVITY
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == 'Mushroom':
			$Health.rect_scale.x = $Health.rect_scale.x - .05
	
	if Input.is_action_just_pressed("ui_select"):
			if attacking:
				pass
			else:
				attackType = randi() % 3
				attacking = true
		
	if is_on_floor():
		grabState = false
		grabDirection = ''
		
		if attacking:
			if $PlayerSprite.flip_h == false:
				motion.x = 1
			elif $PlayerSprite.flip_h == true:
				motion.x = -1
			else:
				pass
				
			if attackType == 0:
				$PlayerSprite.play("Attack")
			elif attackType == 1:
				$PlayerSprite.play("Attack2")
			elif attackType == 2:
				$PlayerSprite.play("Attack3")
			else:
				pass
		
		if motion.x == 0 && motion.y < 21:
			$PlayerSprite.play('Idle')
		
		if Input.is_action_pressed("ui_right"):
			if attacking:
				if $PlayerSprite.get_animation() == "FallAttack":
					motion.x = 0
				else:
					pass
					
				if $PlayerSprite.get_frame() < 2:
					motion.x = 1
				elif $PlayerSprite.get_frame() > 3:
					motion.x = SPEED
				else:
					motion.x = SPEED + 150
			else:
				motion.x = SPEED
				$PlayerSprite.flip_h = false
				$PlayerSprite.play('Run')
		elif Input.is_action_pressed("ui_left"):
			if attacking:
				if $PlayerSprite.get_animation() == "FallAttack":
					motion.x = 0
				else:
					pass
					
				if $PlayerSprite.get_frame() < 2:
					motion.x = 1
				elif $PlayerSprite.get_frame() > 3:
					motion.x = -SPEED
				else:
					motion.x = -SPEED - 150
			else:
				motion.x = -SPEED
				$PlayerSprite.flip_h = true
				$PlayerSprite.play('Run')
		else:
			motion.x = 0
			
		if Input.is_action_pressed("ui_up"):
			if attacking:
				if $PlayerSprite.get_animation() == "FallAttack":
					motion.y = 0
				else:
					pass
			else:
				motion.y = JUMP_HEIGHT
	elif is_on_wall():
		$PlayerSprite.play('WallSlide')
		grabState = false
		grabDirection = ''
		if Input.is_action_pressed("ui_right") && $PlayerSprite.flip_h == false:
			grabState = true
			grabDirection = 'right'
			
		if Input.is_action_pressed("ui_left") && $PlayerSprite.flip_h == true:
			grabState = true
			grabDirection = 'left'		
	else:
		if Input.is_action_pressed("ui_right"):
			if grabDirection == 'right':
				pass
			else:
				motion.x = SPEED
				$PlayerSprite.flip_h = false
		if Input.is_action_pressed("ui_left"):
			if grabDirection == 'left':
				pass
			else:
				motion.x = -SPEED
				$PlayerSprite.flip_h = true
		if motion.y < 0:
			if attacking:
				$PlayerSprite.play('JumpAttack')
			else:
				$PlayerSprite.play('Jump')
		else:
			if attacking:
				$PlayerSprite.play('FallAttack')
			else:
				$PlayerSprite.play('Fall')
			
	if grabState == true:
		$PlayerSprite.play('WallSlide')
		motion.y = 10
		if grabDirection == 'right':
			$WallParticlesRight.visible = true
			if attacking:
				motion.y = JUMP_HEIGHT
				motion.x = -SPEED
				$PlayerSprite.flip_h = true
				grabState = false
			if Input.is_action_pressed("ui_left"):
				motion.x = -SPEED
				$PlayerSprite.flip_h = false
				grabState = false
			if Input.is_action_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
				motion.x = -SPEED
				$PlayerSprite.flip_h = true
				grabState = false
		elif grabDirection == 'left':
			$WallParticlesLeft.visible = true
			if attacking:
				motion.y = JUMP_HEIGHT
				motion.x = SPEED
				$PlayerSprite.flip_h = !$PlayerSprite.flip_h
				grabState = false
			if Input.is_action_pressed("ui_right"):
				motion.x = SPEED
				grabState = false
			if Input.is_action_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
				motion.x = SPEED
				$PlayerSprite.flip_h = !$PlayerSprite.flip_h
				grabState = false
		pass
	else:
		$WallParticlesLeft.visible = false
		$WallParticlesRight.visible = false
	
	motion = move_and_slide(motion, UP)
	pass


func _on_PlayerSprite_animation_finished():
	attacking = false
