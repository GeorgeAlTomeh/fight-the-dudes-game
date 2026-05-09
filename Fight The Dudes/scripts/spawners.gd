extends Node3D

@export var enemy : PackedScene;

@onready var one: Node3D = $one;
@onready var two: Node3D = $two;
@onready var three: Node3D = $three;
@onready var four: Node3D = $four;
@onready var five: Node3D = $five;
@onready var six: Node3D = $six;
@onready var seven: Node3D = $seven;
@onready var eight: Node3D = $eight;
@onready var nine: Node3D = $nine;
@onready var ten: Node3D = $ten;
@onready var eleven: Node3D = $eleven;
@onready var twelve: Node3D = $twelve;

@onready var spawners = [one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve];

var enemiesToSpawn;
var e;

func _ready():
	enemiesToSpawn = 15;
	e = enemiesToSpawn;
	Global.wave = 1;
@export var wave = 1;

@export var shotgun : PackedScene;
@export var ak47 : PackedScene;

var doneOne = false
var doneTwo = false

func _on_timer_timeout() -> void:
	if wave == 4 and not doneOne:
		doneOne = true;
		Global.gun = 'shotgun';
		$"../../player/Head/weapons".get_child(0).queue_free();
		$"../../player/Head/weapons".add_child(shotgun.instantiate());
	elif wave == 7 and not doneTwo:
		doneTwo = true;
		Global.gun = 'ak47';
		$"../../player/Head/weapons".get_child(0).queue_free();
		$"../../player/Head/weapons".add_child(ak47.instantiate());
	if e > 0 and not Global.ui:
		e -= 1;
		spawners.shuffle()
		var enemy_ready = enemy.instantiate()
		get_parent().add_child(enemy_ready)
		enemy_ready.global_position = spawners[0].global_position
		Global.aliveEnemies += 1;
	if Global.aliveEnemies == 0 and wave < 9 and not Global.ui:
		e = enemiesToSpawn + (wave * 5);
		wave += 1;
		Global.enemisForScene = e;
		Global.enemiesTS = e;
		$"../../Control/Label".text = "wave "+str(wave);
		$"../../Control/Label3".text = "wave "+str(wave);
		$"../../Control/Label".show();
		$"../../Control/Timer".start();
	elif wave == 9 and Global.aliveEnemies == 0:
		#get_tree().change_scene_to_file('res://scenes/win.tscn')
		Global.health = 100;
		Global.aliveEnemies = 0;
		Global.wave = 1;
		$"../../player".queue_free();
		Global.ui = true;
		$"../../Control/menus/win".show();
	Global.wave = wave;

func _on_timer2_timeout() -> void:
	$"../../Control/Label".hide();
