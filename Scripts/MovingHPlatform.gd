extends Node2D


onready var followNode = $Path2D/PathFollow2D
var SPEED = 125
var playerPresent = false
var playerBody = null

func _ready():
	set_process(true)

func _process(delta):		
	followNode.set_offset(followNode.get_offset() + SPEED * delta)
