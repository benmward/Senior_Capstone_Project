// Draw bar to display remaining time
draw_healthbar(352, 8, 672, 38, ((testtime / totaltime) * 100), c_black, c_blue, c_blue, 0, true, true);
draw_set_halign(fa_left);
draw_set_colour(c_white);
draw_set_font(ft_basic16);
draw_text(440, 10, "Time Remaining");
