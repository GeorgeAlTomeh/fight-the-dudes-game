extends Control

func _ready() -> void:
	$Control/Label.text = str(Global.time);

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	Global.health = 100;
	Global.aliveEnemies = 0;
	Global.wave = 1;
	Global.enemisForScene = 15;
	Global.enemiesTS = 15;
	get_tree().reload_current_scene();
