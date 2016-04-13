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
        
        


var i = 0;
var starti = 0;
var k = 0;
        
// All previous scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_italic24);
draw_text(300,64,"Previous Scores...");



// ATTENTION GAME scores
draw_set_font(ft_basic16);
draw_set_color(c_maroon);
draw_text(300,120,"Basic Attention Game Scores: ");
if(global.attngamenumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.attngamenumb > 11){
    starti = 11;
}else{
    starti = global.attngamenumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 140, string(ini_read_real('ATTNGAME',string(global.attngamenumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 140, string(ini_read_real('ATTNGAME',string(global.attngamenumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// MEM GAME scores
draw_set_font(ft_basic16);
draw_set_color(c_maroon);
draw_text(300,170,"Basic Memory Game Scores: ");
if(global.memgamenumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.memgamenumb > 11){
    starti = 11;
}else{
    starti = global.memgamenumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 190, string(ini_read_real('MEMGAME',string(global.memgamenumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 190, string(ini_read_real('MEMGAME',string(global.memgamenumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0
}



// ATTN TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,220,"Basic Attention Test Scores: ");
if(global.attntestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.attntestnumb > 11){
    starti = 11;
}else{
    starti = global.attntestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 240, string(ini_read_real('BASICATTN',string(global.attntestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 240, string(ini_read_real('BASICATTN',string(global.attntestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// MEM TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,270,"Basic Memory Test Scores: ");
if(global.memtestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.memtestnumb > 11){
    starti = 11;
}else{
    starti = global.memtestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 290, string(ini_read_real('BASICMEM',string(global.memtestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 290, string(ini_read_real('BASICMEM',string(global.memtestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}


// SPAT MEM TEST scores
draw_set_font(ft_basic16);
draw_set_color(c_purple);
draw_text(300,320,"Spatial Memory Test Scores: ");
if(global.spattestnumb > 1){
//Print all out in a loop
draw_set_color(c_black);
// adjust i if too many scores
if(global.spattestnumb > 11){
    starti = 11;
}else{
    starti = global.spattestnumb;
}
while((i + 1) < starti){
    if((i + 2) < starti){
        draw_text(300 + (k * 64), 340, string(ini_read_real('SPATMEM',string(global.spattestnumb - (k + 1)),0)) + ", " );
    }else{
        draw_text(300 + (k * 64), 340, string(ini_read_real('SPATMEM',string(global.spattestnumb - (k + 1)),0)));
    }
    k++;
    i++;
}
// reset vars
i = 0;
starti = 0;
k = 0;
}



// draws progress
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_set_font(ft_italic24);
draw_text(512,8, string(global.user) + "'s Progress Report");

// Recent Scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,60,"Most Recent Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,106,"Basic Attention Game: ");
draw_set_color(c_lime);
draw_text(220,106,string(global.attngamescore));

draw_set_color(c_white);
draw_text(8,136,"Basic Memory Game: ");
draw_set_color(c_lime);
draw_text(220,136,string(global.memgamescore));

draw_set_color(c_white);
draw_text(8,166,"Basic Attention Test: ");
draw_set_color(c_lime);
draw_text(220,166,string(global.attnscore));

draw_set_color(c_white);
draw_text(8,196,"Basic Memory Test: ");
draw_set_color(c_lime);
draw_text(220,196,string(global.memscore));

draw_set_color(c_white);
draw_text(8,226,"Spatial Memory Test: ");
draw_set_color(c_lime);
draw_text(220,226,string(global.spatscore));

// High Scores
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,266,"Highest Scores...");
// The recent scores
draw_set_font(ft_basic16);

draw_set_color(c_white);
draw_text(8,306,"Basic Attention Game: ");
draw_set_color(c_lime);
draw_text(220,306,string(hiattngame));

draw_set_color(c_white);
draw_text(8,336,"Basic Memory Game: ");
draw_set_color(c_lime);
draw_text(220,336,string(himemgame));

draw_set_color(c_white);
draw_text(8,366,"Basic Attention Test: ");
draw_set_color(c_lime);
draw_text(220,366,string(hiattntest));

draw_set_color(c_white);
draw_text(8,396,"Basic Memory Test: ");
draw_set_color(c_lime);
draw_text(220,396,string(himemtest));

draw_set_color(c_white);
draw_text(8,426,"Spatial Memory Test: ");
draw_set_color(c_lime);
draw_text(220,426,string(hispattest));

// Total Games played
draw_set_halign(fa_left);
draw_set_color(c_navy);
draw_set_font(ft_basic18);
draw_text(8,466,"Total Games/Tests Completed...");
//Games
draw_set_color(c_maroon);
draw_set_font(ft_basic18);
draw_text(8,500,"Games: ");
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(94,514,"Attn:");
draw_text(184,514,"Mem:");
//#played
draw_set_color(c_lime);
draw_text(144,514,string(global.attngamenumb));
draw_text(238,514,string(global.memgamenumb));
//Tests
draw_set_color(c_purple);
draw_set_font(ft_basic18);
draw_text(280,500,"Tests: ");
draw_set_color(c_white);
draw_set_font(ft_basic16);
draw_text(346,514,"Attn:");
draw_text(436,514,"Mem:");
draw_text(530,514,"Spatial Mem:");
//#played
draw_set_color(c_lime);
draw_text(396,514,string(global.attntestnumb));
draw_text(488,514,string(global.memtestnumb));
draw_text(654,514,string(global.spattestnumb));

// Close ini file
ini_close();
