draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(ft_basic20);

// buttons
draw_text((obj_backbutt.x + 58), (obj_backbutt.y + 36), "Back To Menu");


// Load all of the game data from the user's profile
        // open user's save file
        ini_open(string(global.userini));
        // Get the previous number for all scores
        global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
        global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
        global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
        
        // Get most recent scores
        global.attngamescore = ini_read_real('ATTNGAME',string(global.attngamenumb),0);
        global.attnscore = ini_read_real('BASICATTN',string(global.attntestnumb),0);
        global.memscore = ini_read_real('BASICMEM',string(global.memtestnumb),0);
        
        // Get the highscores
        var hiattngame = ini_read_real('ATTNGAME','HIGHSCORE',0);
        var himemgame = 0;
        var hiattntest = ini_read_real('BASICATTN','HIGHSCORE',0);
        var himemtest = ini_read_real('BASICMEM','HIGHSCORE',0);
        var hispattest = 0;
        
        
        // Close ini file
        ini_close();


// draws progress
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_set_font(ft_italic24);
draw_text(512,8, string(global.user) + "'s Progress Report");

// Recent Scores
draw_set_halign(fa_left);
draw_set_color(c_orange);
draw_set_font(ft_basic18);
draw_text(8,60,"Most Recent Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,106,"Basic Attention Game: ");
draw_set_color(c_aqua);
draw_text(220,106,string(global.attngamescore));

draw_set_color(c_white);
draw_text(8,136,"Basic Memory Game: ");
draw_set_color(c_aqua);
draw_text(220,136,string(global.memgamescore));

draw_set_color(c_white);
draw_text(8,166,"Basic Attention Test: ");
draw_set_color(c_aqua);
draw_text(220,166,string(global.attnscore));

draw_set_color(c_white);
draw_text(8,196,"Basic Memory Test: ");
draw_set_color(c_aqua);
draw_text(220,196,string(global.memscore));

draw_set_color(c_white);
draw_text(8,226,"Spatial Memory Test: ");
draw_set_color(c_aqua);
draw_text(220,226,string(global.spatscore));

// High Scores
draw_set_halign(fa_left);
draw_set_color(c_orange);
draw_set_font(ft_basic18);
draw_text(8,266,"Highest Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,306,"Basic Attention Game: ");
draw_set_color(c_aqua);
draw_text(220,306,string(hiattngame));

draw_set_color(c_white);
draw_text(8,336,"Basic Memory Game: ");
draw_set_color(c_aqua);
draw_text(220,336,string(himemgame));

draw_set_color(c_white);
draw_text(8,366,"Basic Attention Test: ");
draw_set_color(c_aqua);
draw_text(220,366,string(hiattntest));

draw_set_color(c_white);
draw_text(8,396,"Basic Memory Test: ");
draw_set_color(c_aqua);
draw_text(220,396,string(himemtest));

draw_set_color(c_white);
draw_text(8,426,"Spatial Memory Test: ");
draw_set_color(c_aqua);
draw_text(220,426,string(hispattest));
