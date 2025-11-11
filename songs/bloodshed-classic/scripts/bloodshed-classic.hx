import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;
var time:Float = 0;
var rain:FlxTypedEmitter = new FlxTypedEmitter(-1280,0, 1280);
var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); 
rain.loadParticles(Paths.image("stages/raindrop"),500);
rain.scale.set(0.5, 0.5, 1, 1);
rain.lifespan.set(0);
rain.velocity.set(-20, 400,20,800);
rain.keepScaleRatio = true;
rain.width = 1280*4;
rain.start(false, 0.01);
var rain = new CustomShader("rain");
function update(elapsed:Float){time += elapsed;
	rain.iTime = time;
	iconP2.alpha = (2-(health)-0.15)/1+0.2;
	iconP1.alpha = (health-0.15)/1+0.2;
}
function beatHit(curBeat:Int) {
	switch(curBeat){
		case 1:
		FlxTween.tween(healthBar, {alpha: 0}, 0.3, {ease: FlxEase.circOut});
		FlxTween.tween(healthBarBG, {alpha: 0}, 0.3, {ease: FlxEase.circOut});
		case 64|224:
		defaultCamZoom = 1;
		case 72:
		defaultCamZoom = 0.65;
		evilTrail.color = FlxColor.RED;
		insert(members.indexOf(dad)-1, evilTrail);
		FlxG.camera.flash(FlxColor.WHITE, 1);
		if (FlxG.save.data.rain) {
		FlxG.camera.addShader(rain);rain.zoom = 40;
		rain.raindropLength = 0.1;rain.opacity = 0.25;}
		case 136:
		defaultCamZoom = 0.8;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		rain.opacity = 0.0;
		case 216|248:
		defaultCamZoom = 0.9;
		case 228:
		defaultCamZoom = 1.05;	
		case 232:
		//missval = false;
		defaultCamZoom = 0.65;
		//addShader(camGame, "rain");
        rain.zoom = 40;
        rain.raindropLength = 0.8;
		rain.opacity = 0.25;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		case 264:
		defaultCamZoom = 0.65;
		case 296:
		defaultCamZoom = 0.8;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		//missval = true;
        rain.zoom = 40;
        rain.raindropLength = 0.1;
        rain.opacity = 0.0;
	}
}
