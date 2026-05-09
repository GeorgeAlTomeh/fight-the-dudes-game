extends CenterContainer

# make the crosshair change when the player move variables
@export var reticle_lines : Array[Line2D]
@export var player_controller : CharacterBody3D
@export var reticle_speed : float = 0.25
@export var reticle_distance : float = 2.0

# crosshair characteristics varibles
@export var dot_radius : float = 1.0
@export var dot_color : Color = Color.WHITE

func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	adjust_reticle_lines()


func _draw():
	draw_circle(Vector2(0,0), dot_radius, dot_color)


func adjust_reticle_lines():
	var vel = player_controller.get_real_velocity()
	var speed = vel.length()
	var pos = Vector2(0,0)
	
	# adjust reticle line position 
	reticle_lines[0].position = lerp(reticle_lines[0].position, pos + Vector2(0, -speed * reticle_distance), reticle_speed) # top line
	reticle_lines[1].position = lerp(reticle_lines[1].position, pos + Vector2(speed * reticle_distance, 0), reticle_speed) # right line
	reticle_lines[2].position = lerp(reticle_lines[2].position, pos + Vector2(0, speed * reticle_distance), reticle_speed) # bottom line
	reticle_lines[3].position = lerp(reticle_lines[3].position, pos + Vector2(-speed * reticle_distance, 0), reticle_speed) # left line
