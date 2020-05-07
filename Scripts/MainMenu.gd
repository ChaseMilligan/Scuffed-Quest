extends Control
		
func _on_Button_pressed(sceneToLoad):
	print('hi')
	print(sceneToLoad)
	get_tree().change_scene(sceneToLoad)
