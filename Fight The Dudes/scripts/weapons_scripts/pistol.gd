extends Node3D

@onready var view: RayCast3D = $view
@onready var pistol_animation_player: AnimationPlayer = $pistol_AnimationPlayer
@export var shoot: PackedScene;
@onready var shoot_pos: Node3D = $shootPos
@onready var flash: SpotLight3D = $flash
@onready var timer: Timer = $Timer
@export var bullets : int = 13 
@onready var label: Label = $ui/Label

var reloading = false;

func _ready() -> void:
	Global.gun = 'pistol';

func _process(_delta: float) -> void:
	if Global.gun == 'pistol':
		label.text = str(bullets);
	if Input.is_action_just_pressed("shoot") and bullets > 0 and not reloading and not Global.ui:
		bullets -= 1;
		pistol_animation_player.play("shoot");
		var scene = shoot.instantiate();
		scene.position = shoot_pos.global_position;
		get_parent().get_parent().get_parent().get_parent().add_child(scene);
		flash.show();
		timer.start();
		if view.is_colliding():
			if view.get_collider().is_in_group("enemy"):
				view.get_collider().get_parent().health -= 1;
			if view.get_collider().is_in_group("head"):
				view.get_collider().get_parent().health -= 2;
	if Input.is_action_just_pressed("reload") and bullets < 13:
		$pistol_AnimationPlayer.play("reload");
		reloading = true;
		bullets = 13;
	if bullets == 0:
		$pistol_AnimationPlayer.play("reload");
		reloading = true;
		bullets = 13;

func _on_timer_timeout() -> void:
	flash.hide()

func _on_pistol_animation_player_animation_finished(_anim_name: StringName) -> void:
	reloading = false;
