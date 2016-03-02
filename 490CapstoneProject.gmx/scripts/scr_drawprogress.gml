// draws progress
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic22);
draw_text(720,4,"Progress Report");
draw_set_font(ft_basic16);
draw_text(720,54,"Previous Attention Score: " + string(global.attnscore) + " / 20");
