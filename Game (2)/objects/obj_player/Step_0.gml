right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_down);
down_key = keyboard_check(vk_up);

xspd = (right_key - left_key) * move_speed;
yspd = (up_key - down_key) * move_speed;

//collisions
if place_meeting(x + xspd, y, obj_wall) == true
	{
		xspd = 0;
	};
if place_meeting(x, y + yspd, obj_wall) == true
	{
		yspd = 0;
	};

x += xspd;
y += yspd;


if(keyboard_check(vk_space)){
	var _inst = instance_create_depth(x,y, depth, obj_attack)
	_inst.image_angle = point_direction(0, 0, xspd, yspd);
	_inst.damage *= damage;
}

var _xinput = keyboard_check(vk_right) - keyboard_check(vk_left);
var _yinput = keyboard_check(vk_down) - keyboard_check(vk_up);

if (_xinput != 0 || _yinput != 0) {
    facing_dir = point_direction(0, 0, _xinput, _yinput);
}

// 2. Trigger the dodge (Spacebar)
if (keyboard_check_pressed(vk_space) && can_dodge && !is_dodging) {
    is_dodging = true;
    can_dodge = false;
    invincible = true;
    
    dodge_dir = facing_dir;
    
    
    image_alpha = 0.5;
    
    alarm[0] = dodge_duration;
    alarm[1] = dodge_cooldown;
}

if (is_dodging) {
    var _hsp = lengthdir_x(dodge_speed, dodge_dir);
    var _vsp = lengthdir_y(dodge_speed, dodge_dir);
    move_and_collide(_hsp, _vsp, obj_wall);
} else {
    if (_xinput != 0 || _yinput != 0) {
        var _hsp = lengthdir_x(move_speed, facing_dir);
        var _vsp = lengthdir_y(move_speed, facing_dir);
        move_and_collide(_hsp, _vsp, obj_wall);
    }
}

