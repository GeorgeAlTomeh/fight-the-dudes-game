extends Control

func _on_inventory_ui_flash_light(value: Variant) -> void:
	if value == true:
		$batteryUI.show();
	elif value == false:
		$batteryUI.hide();

func _on_inventory_ui_battery_decreased(decrease: Variant) -> void:
	$batteryUI/batteryLevel.scale.y = decrease/100.0;
	if decrease <= 100:
		$batteryUI/batteryLevel.color = Color("#30ef1f");
	if decrease <= 50:
		$batteryUI/batteryLevel.color = Color("#ffef1f");
	if decrease <= 25:
		$batteryUI/batteryLevel.color = Color("#f03f1f");
