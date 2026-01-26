extends PanelContainer

@onready var log_label: Label = $MarginContainer/HBoxContainer/Logs/MarginContainer/LogLabel
@onready var corn_label: Label = $MarginContainer/HBoxContainer/Corn/MarginContainer/CornLabel
@onready var tomato_label: Label = $MarginContainer/HBoxContainer/Tomato/MarginContainer/TomatoLabel
@onready var egg_label: Label = $MarginContainer/HBoxContainer/Egg/MarginContainer/EggLabel
@onready var milk_label: Label = $MarginContainer/HBoxContainer/Milk/MarginContainer/MilkLabel
@onready var stone_label: Label = $MarginContainer/HBoxContainer/Stone/MarginContainer/StoneLabel

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = str(inventory["log"])
	if inventory.has("stone"):
		stone_label.text = str(inventory["stone"])
	if inventory.has("egg"):
		egg_label.text = str(inventory["egg"])
	if inventory.has("milk"):
		milk_label.text = str(inventory["milk"])
	if inventory.has("corn"):
		corn_label.text = str(inventory["corn"])
	if inventory.has("tomato"):
		tomato_label.text = str(inventory["tomato"])
