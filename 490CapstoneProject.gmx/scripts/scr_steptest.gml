//Change to random position every 10 steps
pulse++;
if (pulse = 20){
move_random(1,1);
pulse = 0;
}

//Also rotate the test object
image_angle -= 5;

//Swap the transparency.
if (trans == 0){
    image_alpha -= .05;
    if (image_alpha <= .4){
        trans = 1;
    }
}

if (trans == 1){
    image_alpha += .05;
    if (image_alpha >= .7){
        trans = 0;
    }
}
