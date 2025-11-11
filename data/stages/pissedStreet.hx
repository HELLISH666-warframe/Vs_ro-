import flixel.effects.particles.FlxTypedEmitter;
var wasdark = false;
var moveing:Bool = false;
var time:Float = 0;

var rain:flixel.effects.particles.FlxTypedEmitter;
rain = new FlxTypedEmitter(-1280,0, 1280);
rain.loadParticles(Paths.image("stages/raindrop"),500);
rain.scale.set(0.5, 0.5, 1, 1);
rain.lifespan.set(0);
rain.velocity.set(-20, 400,20,800);
rain.keepScaleRatio = true;
rain.width = 1280*4;
rain.start(false, 0.01);
var rain = new CustomShader("rain");

function postCreate() {
	if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);
	rain.zoom = 32; rain.raindropLength = 0.03; rain.opacity = 0.125;}
	truefog.screenCenter();
	insert(members.indexOf(stage.getSprite("mountains")), truefog);
	truefog.visible = false;
	fog.screenCenter();
	fog.camera = camHUD;
	remove(fog);
}
public function underwater(){
	sky.visible = !sky.visible;
	city.visible = !city.visible;
	mountains.visible = !mountains.visible;
	hillfront.visible = !hillfront.visible;
	street.visible = !street.visible;
	underwater.visible = !underwater.visible;
	moveing = !moveing;
	if (FlxG.save.data.rain)rain.opacity = 0;
	dad.angle=boyfriend.angle=gf.angle=0;
}
function darkness() {
	wasdark = !wasdark;
	if (wasdark == true) {
		for (i in stage.stageSprites) FlxTween.cancelTweensOf(i, ['color']);
		truefog.visible = true;
		add(fog).color = 0xFF77ADFF;
		FlxG.camera.flash(0xFF000000, 1, null, true);
		dad.color = boyfriend.color = 0xFF000000;
		truefog.color = 0xFFFFFFFF;
			
		sky.color = city.color = 0xFFFFFFFF;
		mountains.color = hillfront.color = street.color = 0xFF000000;
		street.alpha = 0.5;
		hillfront.alpha = 0.25;
		mountains.alpha = 0.125;
			
		gf.alpha = 0.75;
		gf.color = 0xFF000000;
	if (FlxG.save.data.rain) {rain.zoom = 40; rain.raindropLength = 0.1; rain.opacity = 0.3;}
	}
	else
	{
		if (FlxG.save.data.rain){rain.zoom = 36; rain.raindropLength = 0.07; rain.opacity = 0.2;}
		truefog.visible = false;
		remove(fog);
		var it = 0; 
		for (i in stage.stageSprites) {
			if (i.color == 0xFF000000)
				FlxTween.color(i, (Conductor.crochet/2000), 0xFF000000, 0xFFFFFFFF, {ease: FlxEase.circOut});
		}
		FlxTween.color(dad, (Conductor.crochet/2000), 0xFF000000, 0xFFFFFFFF, {ease: FlxEase.circOut});
		for (i in [gf, boyfriend])
			FlxTween.color(i, (Conductor.crochet/2000), 0xFF000000, 0xFFdbcfb3, {ease: FlxEase.circOut});

		street.alpha = hillfront.alpha = mountains.alpha = gf.alpha = 1;
	}
}
function update(elapsed) {
	time += elapsed;
	rain.iTime = time;
	if (moveing) {
	for (i in 0...cpuStrums.members.length) cpuStrums.members[i].y += Math.sin((curStep+i%1)/4)/2;
	for (i in 0...playerStrums.members.length) playerStrums.members[i].y += Math.sin((curStep+i*2)/4)/2;
	boyfriend.y += Math.sin(curStep/6)/2;
	dad.y -= Math.sin(curStep/6)/2;
	gf.y += Math.sin(curStep/4)/2;
	gf.angle += 0.7;
	boyfriend.angle += Math.sin(curStep/8)/6;
	dad.angle -= Math.sin(curStep/8)/6;
	}
}
function fade()
{
	var it = 1; 
	for (i in stage.stageSprites) {
		FlxTween.color(i, (Conductor.crochet/1000) * 4.5,0xFFFFFFFF, 0xFF000000);
	}
}