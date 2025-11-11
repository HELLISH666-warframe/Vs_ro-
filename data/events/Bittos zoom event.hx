function onEvent(_) {
    if (_.event.name == 'Bittos zoom event') {
        var value1:String = _.event.params[0];
        var value2:String = _.event.params[1];
        var value3:String = _.event.params[2];
        defaultCamZoom = Std.parseFloat(value1);
        FlxTween.tween(FlxG.camera, {zoom: value1}, value2, {ease: CoolUtil.flxeaseFromString(value3)});}
    trace(defaultCamZoom);
}