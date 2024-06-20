extends Camera2D

var deltaMove = 1
var deltaMouse = 300
var locked: bool

var moveToZero = false

func _ready():
	pass

func _process(delta):
	if locked:
		return
	
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
		self.position.x = self.position.x - 10 * indexX
		self.position.y = self.position.y - 10 * indexY
		if abs(self.position.x) < 10 && abs(self.position.y) < 10:
			self.position = Vector2.ZERO
			moveToZero = false;
	else:
		if Input.is_action_pressed("left_click"):
			moveToZero = true
		if Input.is_action_pressed("ui_right"):
			self.position.x = self.position.x + deltaMove
		if Input.is_action_pressed("ui_left"):
			self.position.x = self.position.x - deltaMove
		if Input.is_action_pressed("ui_down"):
			self.position.y = self.position.y + deltaMove
		if Input.is_action_pressed("ui_up"):
			self.position.y = self.position.y - deltaMove
