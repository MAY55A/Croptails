extends Node

signal give_crops_seeds
signal feed_animals

func action_give_crop_seeds() -> void:
	give_crops_seeds.emit()
	
func action_feed_animals() -> void:
	feed_animals.emit()
