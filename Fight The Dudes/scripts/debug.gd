extends PanelContainer

var property
var frames_per_second : String

@onready var property_container: VBoxContainer = %VBoxContainer


func _ready() -> void:
	
	# hide debug panel on load 
	visible = false
	
	add_debug_property("fps ", (frames_per_second))


func _process(delta: float) -> void:
	if visible:
		# use delta time to get approx frames per second and round to two decimal places !disable VSync if fps is stuck at 60!
		frames_per_second = "%.2f" % (1.0/delta) # gets frames per second every frame 
		# frames_per_second = Engine.get_frames_per_second() # gets frames per secnod every second
		property.text = property.name + ": " + frames_per_second


func _input(event: InputEvent) -> void:
	
	# toggle debug panel
	if event.is_action_pressed("debug"):
		visible = !visible


# callable function to add new debug property 
func add_debug_property(title : String,value):
	
	property = Label.new() # create new label node
	property_container.add_child(property) # addd new node as child to VBox container
	property.name = title # set name to title
	property.text = property.name + value
