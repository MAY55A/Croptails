extends Node

signal give_crops_seeds

func action_give_crop_seeds() -> void:
	give_crops_seeds.emit()
