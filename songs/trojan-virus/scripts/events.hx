import flixel.effects.particles.FlxTypedEmitter;
var glitch = new CustomShader("glitchsmh");
var chrom = new CustomShader("chromatic aberration");
var vhs = new CustomShader("vhs");
var time:Float = 0;
var rain = new FlxTypedEmitter(-1280,0, 1280).loadParticles(Paths.image("stages/raindrop"),500);
rain.scale.set(0.5, 0.5, 1, 1);
rain.lifespan.set(0);
rain.velocity.set(-20, 400,20,800);
rain.keepScaleRatio = true;
rain.width = 1280*4;
rain.start(false, 0.01);
var moveing:Bool = playCutscenes = false;
var rain = new CustomShader("rain");
var defaultStrumX:Array<Float> = [50,162,274,386];
var defaultStrumX2:Array<Float> = [730,842,954,1066];

function update(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	for(i in [glitch,rain,vhs])
		i.iTime=time;
	if (moveing){
		for (i in 0...cpuStrums.members.length) cpuStrums.members[i].x = defaultStrumX[i]+ 32 * Math.sin((time*2 + i*0.25) * Math.PI);
		for (i in 0...playerStrums.members.length) playerStrums.members[i].x = defaultStrumX2[i]+ 32 * Math.sin((time*2 + i*0.25) * Math.PI);
	}
	if (!moveing){
		for (i in 0...cpuStrums.members.length) cpuStrums.members[i].x = defaultStrumX[i];
		for (i in 0...playerStrums.members.length) playerStrums.members[i].x = defaultStrumX2[i];
	}
}
function postCreate() {
if (FlxG.save.data.rain){FlxG.camera.addShader(rain);rain.zoom = 35;
	rain.raindropLength = 0.075;rain.opacity = 0.2;
	}
}
function stepHit(step){
	switch (step){
	case 384:
		if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
		if (FlxG.save.data.vhs)FlxG.camera.addShader(vhs);
		if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);glitch.on = 1.;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		camHUD.shake(0.002);
		defaultCamZoom = 0.8;
		moveing = true;
	case 640:
		moveing = false;
		if (FlxG.save.data.glitch)glitch.on = 0.;
		defaultCamZoom = 0.55;
	case 912:
		moveing = true;
		if (FlxG.save.data.glitch)glitch.on = 1.;
		defaultCamZoom = 0.88;
	case 1160|1164|1165|1166|1167:
		window.move(window.x + FlxG.random.int(-50, 50),window.y + FlxG.random.int(-32, 32));
	case 1432:
		moveing = false;
		if (FlxG.save.data.glitch)FlxG.camera.removeShader(glitch);
		FlxTween.tween(camHUD, {alpha: 0}, 2, {ease: FlxEase.circInOut});
	case 1490:
		defaultCamZoom = 1;
	case 1552:
		var budjet = new FlxSprite(0, 0).loadGraphic(Paths.image('ron/budjet'));
		budjet.scrollFactor.set();
		budjet.screenCenter();
		budjet.camera = camOther;
		add(budjet);
		dad.visible = false;
		defaultCamZoom = 0.9;
	}
	if ((curStep >= 384) && (curStep <= 640)){
	FlxG.camera.shake(0.00625, 0.1);
	camHUD.shake(0.00125, 0.15);
	}
}