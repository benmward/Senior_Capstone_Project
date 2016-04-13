// Check if SFX are on
if(global.togsfx == 1){
sfx += 1;

    // If sfx is 100, generate sfx
    if (sfx == ticker){
        // Create sfx in room at bottom randomly
        instance_create(irandom_range(0, room_width),room_height,obj_sfx);
        sfx = 0;
        ticker = irandom_range(60, 170);
    }
}
