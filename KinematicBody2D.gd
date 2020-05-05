extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -625

var motion = Vector2()
var grabState = false
var grabDirection = ''

func _physics_process(delta):
	motion.y += GRAVITY
		
	if is_on_floor():
		grabState = false
		grabDirection = ''
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			$PlayerSprite.flip_h = false
			$PlayerSprite.play('Run')
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			$PlayerSprite.flip_h = true
			$PlayerSprite.play('Run')
		elif Input.is_action_just_pressed("ui_select"):
			$PlayerSprite.play('Attack1')
			if Input.is_action_pressed("ui_right"):
				pass
			if Input.is_action_pressed("ui_left"):
				pass
		else:
			motion.x = 0
			$PlayerSprite.play('Idle')
			
		if Input.is_action_pressed("ui_up"):
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
			if grabDirection != '':
				pass
			else:
				motion.x = SPEED
				$PlayerSprite.flip_h = false
		if Input.is_action_pressed("ui_left"):
			if grabDirection != '':
				pass
			else:
				motion.x = -SPEED
				$PlayerSprite.flip_h = true
		if motion.y < 0:
			$PlayerSprite.play('Jump')
		else:
			$PlayerSprite.play('Fall')
			
	if grabState == true:
		$PlayerSprite.play('WallSlide')
		motion.y = 10
		if grabDirection == 'right':
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
			if Input.is_action_pressed("ui_right"):
				motion.x = SPEED
				grabState = false
			if Input.is_action_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
				motion.x = SPEED
				$PlayerSprite.flip_h = !$PlayerSprite.flip_h
				grabState = false
		pass
		
	motion = move_and_slide(motion, UP)
	pass
