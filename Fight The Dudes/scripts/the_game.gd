extends Node3D

@onready var start_menu: Control = $Control/menus/start_menu
@onready var explanation_page: Control = $Control/menus/explanation_page
@onready var win: Control = $Control/menus/win
@onready var lose_menu: Control = $Control/menus/lose_menu

var minutes = 0;
var seconds = 0;
var miliseconds = 0;

var ss = ':';

func _on_timer_2_timeout() -> void:
	var formattedText = '';
	if not Global.ui:
		miliseconds += 1;
		if miliseconds == 10:
			miliseconds = 0;
			seconds += 1;
			if seconds == 60:
				seconds = 0;
				miliseconds = 0;
				minutes += 1;
	if minutes <= 9:
		formattedText = '0';
	else:
		formattedText = '';
	if seconds <= 9:
		ss = ':0';
	else:
		ss = ':';
	formattedText += str(minutes) + ss + str(seconds) + ":0" + str(miliseconds);
	Global.time = formattedText;
	$Control/Label2.text = formattedText;
