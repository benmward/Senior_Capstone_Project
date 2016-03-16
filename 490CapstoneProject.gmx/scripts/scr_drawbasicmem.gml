var wordhor = 512;
var wordver = 200;

// Display Word
if (dispmode == 1){
draw_set_font(ft_mem);
draw_set_halign(fa_center);
draw_set_color(c_white);

draw_text(wordhor, wordver, letters);
}

if (ansmode == 1){
draw_set_font(ft_mem);
draw_set_halign(fa_center);
if (done == 0){
    draw_set_color(c_red);
}
if (done == 1 && correct = 0){
    draw_set_color(c_ltgray);
}
if (done == 1 && correct = 1){
    draw_set_color(c_green);
}

draw_text(wordhor, wordver, entry);

// Draw correct if wrong
if (done == 1 && correct = 0){
    draw_set_color(c_dkgray);
    draw_set_font(ft_memwrong);
    draw_text(wordhor, (wordver + 120), letters);
}

}

// Drawing time bars
if (ansmode == 1 || dispmode == 1){
    if (ansmode == 1){
        draw_healthbar(372, 120, 652, 160, ((tick / (answertime * 30)) * 100), c_navy, c_teal, c_teal, 0, true, true);
        draw_set_halign(fa_left);
        draw_set_colour(c_white);
        draw_set_font(ft_basic16);
        draw_text(440, 128, "Time to Answer");
    }
    
    if (dispmode == 1){
        draw_healthbar(372, 120, 652, 160, ((tick / (disptime * 30)) * 100), c_navy, c_teal, c_teal, 0, true, true);
        draw_set_halign(fa_left);
        draw_set_colour(c_white);
        draw_set_font(ft_basic16);
        draw_text(440, 128, "Time to View");
    }
}
