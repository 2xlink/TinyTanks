extends KinematicBody2D
signal hit
signal fire_bullet(origin, pos)

onready var tracer = $tracer
onready var cd_bullet_refresh = $cd_bullet_refresh
onready var cd_bullet_shoot = $cd_bullet_shoot

# Member variables
const MOTION_SPEED = 160 # Pixels/second
const AIM_DISTANCE = 100 # Pixels

var aim = Vector2()
var ammo = 5

func _ready():
    pass
    

func _physics_process(delta):
    var motion = Vector2()
    aim = Vector2()
    
    if Input.is_action_pressed("move_up"):
        motion += Vector2(0, -1)
    if Input.is_action_pressed("move_bottom"):
        motion += Vector2(0, 1)
    if Input.is_action_pressed("move_left"):
        motion += Vector2(-1, 0)
    if Input.is_action_pressed("move_right"):
        motion += Vector2(1, 0)
        
    if Input.is_key_pressed(KEY_W):
        aim += Vector2(0, -1)
    if Input.is_key_pressed(KEY_S):
        aim += Vector2(0, 1)
    if Input.is_key_pressed(KEY_A):
        aim += Vector2(-1, 0)
    if Input.is_key_pressed(KEY_D):
        aim += Vector2(1, 0)
    
    motion = motion.normalized() * MOTION_SPEED
    
    if(aim.length() != 0):
        aim = aim.normalized() * AIM_DISTANCE
        tracer.offset = aim
        tracer.visible = true
    else:
        tracer.visible = false
    
    move_and_slide(motion)
    
    
func _process(delta):
    if Input.is_key_pressed(KEY_SPACE) && aim.length() != 0 && _can_shoot():
        print(self.name+" wants to fire with ammo "+str(ammo))
        cd_bullet_refresh.start()
        ammo -= 1
        cd_bullet_shoot.start()
        emit_signal("fire_bullet", 0, self.position, aim)


func _on_cd_bullet_refresh_timeout():
    if ammo < 5:
        ammo += 1
    else:
        cd_bullet_refresh.stop()
        
        
func _can_shoot():
    return cd_bullet_shoot.time_left == 0 && ammo > 0