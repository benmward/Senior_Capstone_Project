// Check if sfx off
if(global.togsfx == 0){
    instance_destroy();
}

// Varience
image_alpha = .4;
vspeed -= (random_range(0.5, 0.8));

if (hspeed > 0 && hspeed < 8){
    hspeed += (irandom_range(3, 5));
}
else if(hspeed >= 8){
    hspeed = (irandom_range(-5, -3));
}
else if (hspeed < 0 && hspeed > -8){
    hspeed += (irandom_range(-5, 3));
}else{
    hspeed = (irandom_range(3, 5));
}
