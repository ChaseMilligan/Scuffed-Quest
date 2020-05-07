extends Button

export(String) var sceneToLoad

func _process(_delta):
	if is_pressed():
		# Remove the current level
		print('hit')
		assert(get_tree().change_scene("res://Scenes/" + sceneToLoad) == OK)
