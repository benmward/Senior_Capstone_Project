// Make swaying effect
gravity = 0;
dircnt++;

if((dircnt >= 18) && (chngdir == 0)){
    dircnt = 0;
    chngdir = 1;
}

if((dircnt >= 18) && (chngdir == 1)){
    dircnt = 0;
    chngdir = 0;
}

if (chngdir == 0){
    hspeed = 1.5;
}else{
    hspeed = -1.5;
}
