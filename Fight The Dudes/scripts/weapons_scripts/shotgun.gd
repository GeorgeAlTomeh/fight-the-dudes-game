extends Node3D

@onready var view: RayCast3D = $view
@onready var view_2: RayCast3D = $view2
@onready var view_3: RayCast3D = $view3
@onready var view_4: RayCast3D = $view4
@onready var view_5: RayCast3D = $view5
@onready var view_6: RayCast3D = $view6
@onready var view_7: RayCast3D = $view7
@onready var view_8: RayCast3D = $view8
@onready var view_9: RayCast3D = $view9

@onready var view_10: RayCast3D = $view10
@onready var view_11: RayCast3D = $view11
@onready var view_12: RayCast3D = $view12
@onready var view_13: RayCast3D = $view13
@onready var view_14: RayCast3D = $view14
@onready var view_15: RayCast3D = $view15
@onready var view_16: RayCast3D = $view16
@onready var view_17: RayCast3D = $view17


@export var shoot: PackedScene;
@onready var shoot_pos: Node3D = $shootPos
@onready var flash: SpotLight3D = $flash
@onready var timer: Timer = $Timer
@export var bullets : int = 8
@onready var label: Label = $ui/Label
@onready var shotgun_animationplayer: AnimationPlayer = $AnimationPlayer

var reloading = false;
var shooting = false;
var b = false;
var anim = '';

func _ready() -> void:
	Global.gun = 'shotgun';

func _process(_delta: float) -> void:
	if Global.gun =='shotgun':
		label.text = str(bullets);
	if Input.is_action_just_pressed("shoot") and bullets > 0 and not reloading and not shooting:
		bullets -= 1;
		anim = 's';
		shotgun_animationplayer.play("shoot");
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
		
		if view_2.is_colliding():
			if view_2.get_collider().is_in_group("enemy"):
				view_2.get_collider().get_parent().health -= 2;
			if view_2.get_collider().is_in_group("head"):
				view_2.get_collider().get_parent().health -= 3;
		
		if view_3.is_colliding():
			if view_3.get_collider().is_in_group("enemy"):
				view_3.get_collider().get_parent().health -= 2;
			if view_3.get_collider().is_in_group("head"):
				view_3.get_collider().get_parent().health -= 3;
		
		if view_4.is_colliding():
			if view_4.get_collider().is_in_group("enemy"):
				view_4.get_collider().get_parent().health -= 2;
			if view_4.get_collider().is_in_group("head"):
				view_4.get_collider().get_parent().health -= 3;
		
		if view_5.is_colliding():
			if view_5.get_collider().is_in_group("enemy"):
				view_5.get_collider().get_parent().health -= 2;
			if view_5.get_collider().is_in_group("head"):
				view_5.get_collider().get_parent().health -= 3;
		
		if view_6.is_colliding():
			if view_6.get_collider().is_in_group("enemy"):
				view_6.get_collider().get_parent().health -= 2;
			if view_6.get_collider().is_in_group("head"):
				view_6.get_collider().get_parent().health -= 3;
		
		if view_7.is_colliding():
			if view_7.get_collider().is_in_group("enemy"):
				view_7.get_collider().get_parent().health -= 2;
			if view_7.get_collider().is_in_group("head"):
				view_7.get_collider().get_parent().health -= 3;
		
		if view_8.is_colliding():
			if view_8.get_collider().is_in_group("enemy"):
				view_8.get_collider().get_parent().health -= 2;
			if view_8.get_collider().is_in_group("head"):
				view_8.get_collider().get_parent().health -= 3;
		
		if view_9.is_colliding():
			if view_9.get_collider().is_in_group("enemy"):
				view_9.get_collider().get_parent().health -= 2;
			if view_9.get_collider().is_in_group("head"):
				view_9.get_collider().get_parent().health -= 3;
		
		if view_10.is_colliding():
			if view_10.get_collider().is_in_group("enemy"):
				view_10.get_collider().get_parent().health -= 2;
			if view_10.get_collider().is_in_group("head"):
				view_10.get_collider().get_parent().health -= 3;
		
		if view_11.is_colliding():
			if view_11.get_collider().is_in_group("enemy"):
				view_11.get_collider().get_parent().health -= 2;
			if view_11.get_collider().is_in_group("head"):
				view_11.get_collider().get_parent().health -= 3;
		
		if view_12.is_colliding():
			if view_12.get_collider().is_in_group("enemy"):
				view_12.get_collider().get_parent().health -= 2;
			if view_12.get_collider().is_in_group("head"):
				view_12.get_collider().get_parent().health -= 3;
		
		if view_13.is_colliding():
			if view_13.get_collider().is_in_group("enemy"):
				view_13.get_collider().get_parent().health -= 2;
			if view_13.get_collider().is_in_group("head"):
				view_13.get_collider().get_parent().health -= 3;
		
		if view_14.is_colliding():
			if view_14.get_collider().is_in_group("enemy"):
				view_14.get_collider().get_parent().health -= 2;
			if view_14.get_collider().is_in_group("head"):
				view_14.get_collider().get_parent().health -= 3;
		
		if view_15.is_colliding():
			if view_15.get_collider().is_in_group("enemy"):
				view_15.get_collider().get_parent().health -= 2;
			if view_15.get_collider().is_in_group("head"):
				view_15.get_collider().get_parent().health -= 3;
		
		if view_16.is_colliding():
			if view_16.get_collider().is_in_group("enemy"):
				view_16.get_collider().get_parent().health -= 2;
			if view_16.get_collider().is_in_group("head"):
				view_16.get_collider().get_parent().health -= 3;
		
		if view_17.is_colliding():
			if view_17.get_collider().is_in_group("enemy"):
				view_17.get_collider().get_parent().health -= 2;
			if view_17.get_collider().is_in_group("head"):
				view_17.get_collider().get_parent().health -= 3;
		
	if Input.is_action_just_pressed("reload") and bullets < 8 and not reloading and not shooting:
		reloading = true;
		shotgun_animationplayer.play("reload 1");
		await get_tree().create_timer(0.4).timeout
		for i in range(8 - bullets):
			if b:	break
			reloading = true
			shotgun_animationplayer.play("reload 2");
			reloading = true
			await get_tree().create_timer(0.4).timeout
			bullets += 1; 
		reloading = true
		anim = 'r';
		shotgun_animationplayer.play("reload 3")
		reloading = true;
	if bullets == 0 and not reloading and not shooting:
		reloading = true;
		shotgun_animationplayer.play("reload 1");
		await get_tree().create_timer(0.4).timeout
		for i in range(8 - bullets):
			if b:	break
			reloading = true
			shotgun_animationplayer.play("reload 2");
			reloading = true
			await get_tree().create_timer(0.4).timeout
			bullets += 1; 
		reloading = true
		anim = 'r';
		shotgun_animationplayer.play("reload 3")
		reloading = true;

func _on_timer_timeout() -> void:
	flash.hide()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if anim == 'r':
		reloading = false;
	if anim == 's':
		shooting = false;
