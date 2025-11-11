importScript("data/scripts/bloodbleed-shit");
function postCreate()
	firebg.alpha = 0;
function stepHit(curStep){
	switch(curSong) {
	case "bloodshed-classic":
		Estatic.alpha = (((2-health)/3)+0.2);
		switch(curStep){
			case 288|928:FlxTween.tween(firebg, {alpha: 1}, 1, {ease: FlxEase.circOut});
				FlxTween.angle(satan, 0, 359.99, 0.75, {type: FlxTween.LOOPING});
			case 544|1184:FlxTween.tween(firebg, {alpha: 0}, 1, {ease: FlxEase.circOut});
				FlxTween.cancelTweensOf(satan);
				FlxTween.angle(satan, 0, satan.angle+359.99, 3, {ease: FlxEase.circOut});
		}
	case "bleeding-classic":
		if ((curStep >= 256) && (curStep <= 512)) {
			if (fx.alpha < 0.6)
				fx.alpha += 0.05;			
			if (curStep == 256) {
				FlxTween.angle(satan, 0, 359.99, 1.5, { 
					ease: FlxEase.quadIn, 
					onComplete: function(twn:FlxTween) 
					{
						FlxTween.angle(satan, 0, 359.99, 0.75, { type: FlxTween.LOOPING } );
					}} 
				);
			}
			FlxG.camera.shake(0.01, 0.1);
			camHUD.shake(0.001, 0.15);
		}
		else if ((curStep >= 768) && (curStep <= 1296)) {
			if (fx.alpha > 0)
				fx.alpha -= 0.05;
			if (curStep == 768)
			{FlxTween.angle(satan, 0, 359.99, 0.75, { 
					ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) 
					{FlxTween.angle(satan, 0, 359.99, 0.35, {type: FlxTween.LOOPING});}});
			}
			FlxG.camera.shake(0.015, 0.1);
			camHUD.shake(0.0015, 0.15);
		}else{
			if ((curStep == 1297)||(curStep == 614))
				FlxTween.cancelTweensOf(satan);
			if (satan.angle != 0)
				FlxTween.angle(satan, satan.angle, 359.99, 0.5, {ease: FlxEase.quadIn});
			if (fx.alpha > 0.3)
				fx.alpha -= 0.05;
		}
		Estatic.alpha = (((2-health)/3)+0.2);
	}
}