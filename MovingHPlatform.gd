extends Node2D

onready var followNode = get_node("Path2D/PathFollow2D")

func _ready():
	set_process(true)

func _process(delta):
	followNode.set_offset(followNode.get_offset() + 100 * delta)
