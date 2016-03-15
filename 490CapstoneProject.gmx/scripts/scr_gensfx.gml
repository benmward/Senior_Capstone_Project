sfx += 1;

// If sfx is 100, generate sfx
if (sfx == 100){
    // Create sfx in room at bottom randomly
    instance_create(irandom_range(0, room_width),room_height,obj_sfx);
    sfx = 0;
}
