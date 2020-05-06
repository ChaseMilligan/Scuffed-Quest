extends KinematicBody2D

onready var followNode = get_parent()
var SPEED = 125
var hit = false

var moveDirection = false

func _ready():
	$MushroomSprite.play('Run')
	set_process(true)

func _process(delta):	
	$MushroomSprite.flip_h = moveDirection
	
	if hit:
		$MushroomSprite.play('Hurt')
	else:
		$MushroomSprite.play('Run')
	
	var prevPos = followNode.get_global_position()
	followNode.set_offset(followNode.get_offset() + SPEED * delta)
	var pos = followNode.get_global_position()
	
	if followNode.get_unit_offset() >= .5:
		moveDirection = true
	else:
		moveDirection = false


func _on_Area2D_body_entered(body):
	if body.name == "Mushroom":
		hit = true
		$Health.rect_scale.x = $Health.rect_scale.x - .5
		SPEED = -250
		yield(get_tree().create_timer(.25),"timeout")
		SPEED = 125
		hit = false
