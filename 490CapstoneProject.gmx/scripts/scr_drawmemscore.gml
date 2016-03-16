// draws progress
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(800,8,"Correct Answers: " + string(global.memscore) + " / 10");
