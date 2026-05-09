extends Control

func _ready() -> void:
	$HSlider.value = Global.sensitivity*10;
	$Label.text = "sensitivity : "+str($HSlider.value/10);

func _on_texture_button_pressed() -> void:
	hide();
	Global.ui = false;

func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	Global.sensitivity = $HSlider.value/10;
	$Label.text = "sensitivity : "+str($HSlider.value/10);
