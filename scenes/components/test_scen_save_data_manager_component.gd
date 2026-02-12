extends Node
class_name TestSceneSaveDataManagerComponent

func _ready() -> void:
	call_deferred("load_test_scene")

func load_test_scene():
	SaveGameManager.load_game()
