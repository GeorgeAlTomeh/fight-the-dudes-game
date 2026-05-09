extends Control

func _ready() -> void:
	$Control/t.text = str(Global.time);
	$Control/w.text = str(Global.wave);

func _process(_delta: float) -> void:
	$Control/t.text = str(Global.time);
	$Control/w.text = str(Global.wave);

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	Global.health = 100;
	Global.aliveEnemies = 0;
	Global.wave = 1;
	Global.enemisForScene = 15;
	Global.enemiesTS = 15;
	get_tree().reload_current_scene();
