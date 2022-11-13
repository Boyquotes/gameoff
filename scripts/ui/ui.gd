extends Control

@export var items_template: PackedScene
@export var player: NodePath


func changed_item(item_name: String):
	$ItemUI/ItemName.text = item_name


func _on_player_items_ready(items: SpawnableItems) -> void:
	for idx in range(len(items.items)):
		var item = items.items[idx]
		var ui_item = items_template.instantiate()
		$ItemUI.add_child(ui_item)
		ui_item.init(item["name"], idx, get_node(player))


func _on_player_coins_updated(current_coins: int, _previous_coins: int) -> void:
	$Coins.text = str(current_coins)
