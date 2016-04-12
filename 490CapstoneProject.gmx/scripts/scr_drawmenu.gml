draw_set_halign(fa_left);

// Title
draw_set_color(c_fuchsia);
draw_set_font(ft_fancy32);
draw_text(14,36,"Moneta Memory Suite");

// Draw Welcome
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(32,90,"Welcome " + global.user + ".");
draw_set_color(c_silver);
draw_set_font(ft_basic16);
draw_text(32,132,"Please make a selection...");

// Footer
draw_set_color(c_black);
draw_set_font(ft_basic16);
draw_text(770,518,"Created by Benjamin Ward");
