function onEvent(_) {
    if (_.event.name == 'better_tween_zoom') {
        if(_.event.params[4]) defaultCamZoom = Std.parseFloat(_.event.params[0]);
        FlxTween.tween(Reflect.field(state, _.event.params[3]), {zoom: _.event.params[0]}, _.event.params[1], {ease: CoolUtil.flxeaseFromString(_.event.params[2])});}
}