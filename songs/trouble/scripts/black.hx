function beatHit(curBeat:Int) {
if (PlayState.difficulty.toLowerCase() == '2.5' && curBeat == 504) 
{
    var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
	black.scrollFactor.set();
	FlxG.sound.play(Paths.sound('bobSpooky'));
	new FlxTimer().start(1.7, function(tmr:FlxTimer)
	{
		add(black);
		FlxG.camera.fade(FlxColor.WHITE, 0.1, true);
	});
}
}
function postCreate() {
	stage.getSprite("bob").alpha=1;
}