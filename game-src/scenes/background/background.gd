extends Node2D


@onready var background_image: Sprite2D = %Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_viewport_rect().position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
