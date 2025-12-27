var rain = new CustomShader("rain");
var blackeffect = new FlxSprite().makeGraphic(FlxG.width, FlxG.width, FlxColor.BLACK);

var time:Float = 0;
function update(elapsed:Float){time += elapsed;
	rain.iTime = time;
}

function postCreate(){				
	blackeffect.scale.set(4,4);
	blackeffect.updateHitbox();
	blackeffect.antialiasing = true;
	blackeffect.screenCenter();
	blackeffect.scrollFactor.set();
	insert(14,blackeffect).alpha = 0;
}
function stepHit(curStep){
	if (curStep >= 272 && curStep <= 1304) {
		if (curStep % 8 == 0){
			for (i in 0...4){
			FlxTween.globalManager.completeTweensOf(cpuStrums);
			cpuStrums.members[i].y+=20;
			FlxTween.tween(cpuStrums.members[i], {y: 50}, 0.65, {ease: FlxEase.backOut});}
			for (i in 0...4){
			FlxTween.globalManager.completeTweensOf(playerStrums);
			playerStrums.members[i].y+=20;
			FlxTween.tween(playerStrums.members[i], {y: 50}, 0.65, {ease: FlxEase.backOut});}
		    }
		}
	if (curStep == 540||curStep == 604||curStep == 668||curStep == 732||curStep == 1304)
		FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.4, {ease: FlxEase.backOut});
	switch (curStep) {
		case 208|1440: defaultCamZoom = 0.9;
		case 264:
		defaultCamZoom = 1.1;
		case 272: defaultCamZoom = 0.7;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		case 540|668: dad.playAnim('hey');
		case 604|732: boyfriend.playAnim('hey');
		case 1304: if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);
		rain.zoom=35;
		rain.raindropLength=0.075;
		rain.opacity=0.2;}
		boyfriend.color = gf.color = 0xFFdbcfb3;
		fxtwo = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
		fxtwo.scale.set(0.75, 0.75);
		fxtwo.updateHitbox();
		fxtwo.antialiasing = true;
		fxtwo.screenCenter();
		fxtwo.scrollFactor.set(0, 0);
		add(fxtwo).alpha = 0.2;
		fxtwo.camera = camHUD;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		case 1312: defaultCamZoom = 0.8;
		case 1568: FlxTween.tween(blackeffect, {alpha: 1}, 0.5, {ease: FlxEase.circInOut});
		defaultCamZoom = 1.05;
		case 1600: FlxTween.tween(blackeffect, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		defaultCamZoom = 0.8;
	}
}