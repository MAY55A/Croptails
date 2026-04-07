extends Node
class_name SaveLevelDataComponent

var level_scene_name: String
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres"
var game_data_resource: SaveGameDataResource

func _ready() -> void:
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name

func save_node_data() -> void:
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	
	game_data_resource = SaveGameDataResource.new()
	
	if nodes != null:
		for node in nodes:
			if node is SaveDataComponent:
				var save_data_resource: NodeDataResource = node._save_data()
				var save_final_resource =  save_data_resource.duplicate()
				game_data_resource.save_data_nodes.append(save_final_resource)

func save_inventory() -> void:
	game_data_resource.inventory = InventoryManager.inventory

func save_tools_enabled() -> void:
	game_data_resource.all_tools_enabled = ToolManager.all_tools_enabled
	
func save_game() -> void:
	if !DirAccess.dir_exists_absolute(save_game_data_path):
		DirAccess.make_dir_absolute(save_game_data_path)
	
	var level_save_file_name = save_file_name % level_scene_name
	
	save_node_data()
	save_inventory()
	save_tools_enabled()
	
	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + level_save_file_name)
	print ("Save reslut: ", result)


func load_game() -> void:
	var level_save_file_name = save_file_name % level_scene_name
	var save_game_path: String = save_game_data_path + level_save_file_name
	
	if !FileAccess.file_exists(save_game_path):
		return
	
	game_data_resource = ResourceLoader.load(save_game_path)
	
	if game_data_resource == null:
		return
	
	InventoryManager.inventory = game_data_resource.inventory
	InventoryManager.inventory_changed.emit() # trigger UI rerendering
	
	ToolManager.all_tools_enabled = game_data_resource.all_tools_enabled
	# Since tools are disabled initially, we need to activate them if all_tools_enabled is true
	if ToolManager.all_tools_enabled:
		ToolManager.enable_all_tools()
	
	var root_node: Window = get_tree().root
	
	for resource in game_data_resource.save_data_nodes:
		if resource is Resource:
			if resource is NodeDataResource:
				resource._load_data(root_node)
	
	
