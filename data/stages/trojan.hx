//fuck_you_im_having_the_animated_bg_always_loaded
function postCreate() {
    mountainsback.color=FlxColor.RED;
	error.visible = atelo_popup_animated.visible = platform.visible = false;
}
function beatHit(fuck){
    switch (fuck){
        case 96:
        sky.destroy();
        mountainsback.destroy();
        mountains.destroy();
        hillfront.destroy();
        street.destroy();
                
        error.visible = atelo_popup_animated.visible = platform.visible = true;
    }
}