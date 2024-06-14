extends Camera2D

var mode = "scout" # "game"
var camera_movement = ["keyboard", "mouse"]

var deltaMove = 1
var deltaMouse = 300

var moveToZero = false

func _ready():
	pass

func _process(delta):
	if mode == "scout":
		var transform = get_viewport_transform().get_scale()
		var viewport_size = get_viewport().size
		if moveToZero:
			var indexX = 0
			if self.position.x < Vector2.ZERO.x:
				indexX = -1
			elif self.position.x > Vector2.ZERO.x:
				indexX = 1
			var indexY = 0
			if self.position.y < Vector2.ZERO.y:
				indexY = -1
			elif self.position.y > Vector2.ZERO.y:
				indexY = 1
			self.position.x = self.position.x - 1 * indexX
			self.position.y = self.position.y - 1 * indexY
			if absi(self.position.x) < viewport_size.x * transform.x / 5 && absi(self.position.y) < viewport_size.y * transform.y / 5:
				moveToZero = false;
		else:
			if Input.is_action_pressed("left_click"):
				moveToZero = true
			if camera_movement.has("keyboard"):
				if Input.is_action_pressed("ui_right"):
					self.position.x = self.position.x + deltaMove
				elif Input.is_action_pressed("ui_left"):
					self.position.x = self.position.x - deltaMove
				elif Input.is_action_pressed("ui_down"):
					self.position.y = self.position.y + deltaMove
				elif Input.is_action_pressed("ui_up"):
					self.position.y = self.position.y - deltaMove
			if camera_movement.has("mouse"):
				var mouse_position = get_viewport().get_mouse_position()
				if mouse_position.y < deltaMouse && mouse_position.y > -1 * deltaMouse:
					self.position.y = self.position.y - deltaMove
				if mouse_position.y > viewport_size.y / transform.y - deltaMouse && mouse_position.y < viewport_size.y / transform.y + deltaMouse:
					self.position.y = self.position.y + deltaMove
				if mouse_position.x < deltaMouse && mouse_position.x > -1 * deltaMouse:
					self.position.x = self.position.x - deltaMove
				if mouse_position.x > viewport_size.x / transform.x - deltaMouse && mouse_position.x < viewport_size.x / transform.x + deltaMouse:
					self.position.x = self.position.x + deltaMove

func set_mode(md):
	mode = md
