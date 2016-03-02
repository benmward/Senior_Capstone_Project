var wordhor = 512;
var wordver = 125;

draw_set_font(ft_attn);
draw_set_halign(fa_center);

// If the word is visible
if (worddisplay == true){

// red
if(col_variant == 1){
    draw_set_color(c_red);
    if(vis_variant == 1){
    // up
        draw_text(wordhor, wordver, "Up");
    }
    else if(vis_variant == 2){
    // down
        draw_text(wordhor, wordver, "Down");
    }
    else if(vis_variant == 3){
    // left
        draw_text(wordhor, wordver, "Left");
    }
    else{
    // right
        draw_text(wordhor, wordver, "Right");
    }
}
// green
else
{
    draw_set_color(c_green);
    if(vis_variant == 1){
    // up
        draw_text(wordhor, wordver, "Up");
    }
    else if(vis_variant == 2){
    // down
        draw_text(wordhor, wordver, "Down");
    }
    else if(vis_variant == 3){
    // left
        draw_text(wordhor, wordver, "Left");
    }
    else{
    // right
        draw_text(wordhor, wordver, "Right");
    }
}

}
