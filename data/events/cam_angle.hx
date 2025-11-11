function onEvent(_) {//Drifter waz here!!!
if (_.event.name == 'cam_angle') {
        FlxTween.tween(_.event.params[3] ? camHUD : FlxG.camera, 
            {angle: _.event.params[0]},
             _.event.params[1], {ease: CoolUtil.flxeaseFromString(_.event.params[2])});}
}