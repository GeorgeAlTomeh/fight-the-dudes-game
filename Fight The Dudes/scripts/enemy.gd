extends CharacterBody3D

@export var speed = 2

@export var gravity = 9.8

@export var health = 3;

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var holder: Node3D = $holder
@onready var player: CharacterBody3D = $"../../player"
@onready var csg_mesh_3d: CSGBox3D = $holder/CSGMesh3D

func _physics_process(_delta: float) -> void:
	
	if health == 3:
		csg_mesh_3d.size.x = 0.6;
	elif health == 2:
		csg_mesh_3d.size.x = 0.4;
	elif health == 1:
		csg_mesh_3d.size.x = 0.2;
	elif health <= 0:
		Global.aliveEnemies -= 1;
		csg_mesh_3d.size.x = 0;
		Global.enemiesTS -= 1;
		queue_free();
		
	if not Global.ui:
		var direction = to_local(navigation_agent.get_next_path_position()).normalized()
		holder.look_at(player.position)
		velocity = direction * speed
		
		holder.rotation.x = 0;
	
	if velocity.x != 0: 
		$holder/AnimationPlayer.play("walk")
	else:
		$holder/AnimationPlayer.play("idle")
	
	velocity.y -= gravity
	
	move_and_slide()
	
func make_path():
	navigation_agent.target_position = player.global_position
	navigation_agent.target_position.y -= gravity

func _on_timer_timeout() -> void:
	if not Global.ui:
		make_path()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$Timer2.start();

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		$Timer2.stop();

func _on_timer_2_timeout() -> void:
	var arr = [1,2,3];
	arr.shuffle();
	var i = arr[0];
	var anim = 'playerDamage'+str(i);
	$AnimationPlayer.play(anim);
	if Global.health != 0:
		Global.health -= 10;
