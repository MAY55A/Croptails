extends Area2D
class_name CollectableComponent

@export var collectable_name: String



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Collectable")
		get_parent().queue_free()
