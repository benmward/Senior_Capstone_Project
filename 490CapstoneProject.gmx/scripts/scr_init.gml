// Randomize the game seed
randomize();

// Menu Vars
global.esc_time = 0;
global.user = "Jack Sparrow";
global.userini = string(global.user) + ".ini";

// Test Score Vars
global.attnscore = 0;
global.memscore = 0;
global.spatscore = 0;

// Game Score Vars
global.attngamescore = 0;
global.memgamescore = 0;

// other vars
global.gameover = 0;
global.gosignal = 0;
global.togsfx = 1;

// Score loggin numbers, numb = numb of previous scores
ini_open(string(global.userini));
global.attntestnumb = ini_read_real('BASICATTN','NUMB',0);
global.memtestnumb = ini_read_real('BASICMEM','NUMB',0);
global.attngamenumb = ini_read_real('ATTNGAME','NUMB',0);
ini_close();
