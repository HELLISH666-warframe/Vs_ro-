import flixel.addons.effects.FlxTrail;
var bloodshedTrail = null;
var xx = dad.x;
var yy = dad.y;
function resetTrail(){
	remove(bloodshedTrail);
	bloodshedTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); //nice
	bloodshedTrail.color = FlxColor.RED;
	insert(members.indexOf(dad)-1, bloodshedTrail);
}
function update(elapsed:Float){
	iconP2.alpha = (2-(health)-0.15)/1+0.2;
	iconP1.alpha = (health-0.15)/1+0.2;
}
function beatHit(beat) {
	switch(beat){
		case 1:
		FlxTween.tween(healthBar,{alpha: 0},0.3,{ease: FlxEase.circOut});
		FlxTween.tween(healthBarBG,{alpha: 0},0.3,{ease: FlxEase.circOut});
		resetTrail();
		case 62|190:
		FlxG.sound.play(Paths.sound('vine'));
		case 64|192|208|224|256:
		defaultCamZoom += 0.1;
        case 96:
		defaultCamZoom += 0.15;
		case 128:
        defaultCamZoom -= 0.25;
		case 166:
		defaultCamZoom += 0.3;
		case 168:
		defaultCamZoom -= 0.3;
		case 260:
		defaultCamZoom -= 0.2;
		case 292:
		defaultCamZoom -= 0.1;
	}
}
/*
function stepHit(curStep:Int) {
	if ((curStep >= 256) && (curStep <= 512))
		{
			if (fx.alpha < 0.6)
				fx.alpha += 0.05;			
			if (curStep == 256)
			{
				FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 1.5, { 
					ease: FlxEase.quadIn, 
					onComplete: function(twn:FlxTween) 
					{
						FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, { type: FlxTween.LOOPING } );
					}} 
				);
			}
			FlxG.camera.shake(0.01, 0.1);
			camHUD.shake(0.001, 0.15);
		}
		else if ((curStep >= 768) && (curStep <= 1296))
		{
			if (fx.alpha > 0)
				fx.alpha -= 0.05;
			if (curStep == 768)
			{FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, { 
					ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) 
					{FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.35, {type: FlxTween.LOOPING});}});
			}
			FlxG.camera.shake(0.015, 0.1);
			camHUD.shake(0.0015, 0.15);
		}
		else
		{
			if ((curStep == 1297)||(curStep == 614))
				FlxTween.cancelTweensOf(stage.getSprite("satan"));
			if (stage.getSprite("satan").angle != 0)
				FlxTween.angle(stage.getSprite("satan"), stage.getSprite("satan").angle, 359.99, 0.5, {ease: FlxEase.quadIn});
			if (fx.alpha > 0.3)
				fx.alpha -= 0.05;
		}
		Estatic.alpha = (((2-health)/3)+0.2);
}*/