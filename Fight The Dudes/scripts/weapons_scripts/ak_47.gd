extends Node3D

@onready var view: RayCast3D = $view
@onready var ak47_animation_player: AnimationPlayer = $AnimationPlayer
@export var shoot: PackedScene;
@onready var shoot_pos: Node3D = $shootPos
@onready var flash: SpotLight3D = $flash
@onready var timer: Timer = $Timer
@export var bullets : int = 13 
@onready var label: Label = $ui/Label

var reloading = false;
var shooting = false;
var anim = '';

func _ready() -> void:
	Global.gun = 'ak47';

func _process(_delta: float) -> void:
	if Global.gun =='ak47':
		label.text = str(bullets);;
	if Input.is_action_pressed("shoot") and bullets > 0 and not reloading and not shooting:
		bullets -= 1;
		ak47_animation_player.play("shoot");
		anim = 's';
		shooting = true;
		var scene = shoot.instantiate();
		scene.position = shoot_pos.global_position;
		get_parent().get_parent().get_parent().get_parent().add_child(scene);
		flash.show();
		timer.start();
		if view.is_colliding():
			if view.get_collider().is_in_group("enemy"):
				view.get_collider().get_parent().health -= 2;
			if view.get_collider().is_in_group("head"):
				view.get_collider().get_parent().health -= 3;
	if Input.is_action_just_pressed("reload") and bullets < 30 and not shooting:
		$AnimationPlayer.play("reload");
		anim = 'r';
		reloading = true;
		bullets = 30;
	if bullets == 0:
		$AnimationPlayer.play("reload");
		anim = 'r';
		reloading = true;
		bullets = 30;

func _on_timer_timeout() -> void:
	flash.hide()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if anim == 'r':
		reloading = false;
	shooting = false;
