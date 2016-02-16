#define scr_createtest
// timer for position change.
pulse = 0;
trans = 0;
image_alpha = .7;

#define scr_steptest
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

#define scr_outsideroomtest
//If outside, jump to center.
self.x = 448;
self.y = 224;

#define scr_drawmenu
draw_set_font(ft_basic32);
draw_text(20,20,"Moneta Memory Suite");
draw_set_font(ft_basic20);
draw_text(20,70,"By Benjamin Ward. Application under development.");

