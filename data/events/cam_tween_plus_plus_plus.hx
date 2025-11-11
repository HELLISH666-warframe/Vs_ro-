function onEvent(_) {
if (_.event.name == 'cam_tween_plus_plus_plus') {
        if(_.event.params[6]) defaultCamZoom = Std.parseFloat(_.event.params[2]);
        FlxTween.tween(_.event.params[5] ? camHUD : FlxG.camera, 
            {angle: _.event.params[0],alpha: _.event.params[1],zoom: _.event.params[2]},
             _.event.params[3], {ease: CoolUtil.flxeaseFromString(_.event.params[4])});}
}
}