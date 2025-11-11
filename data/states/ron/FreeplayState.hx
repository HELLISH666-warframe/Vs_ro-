import Alphabetthing;
import flixel.graphics.FlxGraphic;
import funkin.backend.chart.Chart;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;

var time = 0;
var chrom = new CustomShader("chromatic aberration");
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

songs = [];
songRealList = [["ron","wasted","ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding"]];
modelist = ["MAIN","CLASSIC","EXTRAS"];

for(s in songRealList[FlxG.save.data.freeplaything]) songs.push(Chart.loadChartMeta(s, "hard", true));
var camText = new FlxCamera();
camText.bgColor = null;
var portrait = new FlxSprite();
var portraitOverlay = new FlxSprite();
var preload = [];
var grpSongs2 = new FlxTypedGroup();
var iconArray2:Array<HealthIcon> = [];
var modeText = new FlxText(0,0,0,modelist[FlxG.save.data.freeplaything],0);
modeText.setFormat(Paths.font("w95.otf"),48,FlxColor.WHITE);
static var curSelectReal = [0,0,0];
function postUpdate(elapsed:Float){time += elapsed;
	if(controls.BACK)FlxG.switchState(new ModState('MasterFreeplayState'));
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	vhs.data.iTime.value = glitch.data.iTime.value = [time];

	for (i in 0...songs.length) grpSongs2.members[i].y += (Math.sin(i+time)/2);
	for (item in grpSongs2.members)
		item.forceX = FlxMath.lerp(item.x, 125 + (65 * (item.ID - curSelected)),lerpFix(0.1));
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;

	for (i in 0...grpSongs2.length)
		iconArray2[i].setPosition(grpSongs2.members[i].x+grpSongs2.members[i].width+10,grpSongs2.members[i].y-55);
}
function create(){
	add(grpSongs2);
	for (i in 0...songs.length) {
		var songText = new Alphabetthing(0, (70 * i) + 30, songs[i].displayName, true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		songText.ID = i;
		songText.camera = camText;
		grpSongs2.add(songText);
		var icon = new HealthIcon(songs[i].icon);
		iconArray2.push(icon);
		add(icon);
	}
	for (i in 0...iconArray2.length) remove(iconArray2[i]);
	curSelected=curSelectReal[FlxG.save.data.freeplaything];
	insert(2,modeText);
	insert(2,portrait).updateHitbox();
}
function shadering(){
	var cursong = songs[curSelected].displayName;
    switch(cursong)
    {
		case"gron":if(FlxG.save.data.grey)FlxG.camera.addShader(grey);camText.addShader(grey);
		case"trojan-virus":glitch.on = 1.;
		case"Bleeding":diffText.color=0xE00020;glitch.on = 1.;
		default:FlxG.camera.removeShader(grey);camText.removeShader(grey);
		glitch.on = 0;diffText.color=0xFFFFFFFF;
    }
	if (Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong+'-over'))) {
		portraitOverlay.loadGraphic(Paths.image('menus/freeplay/portraits/'+cursong+'-over'));
		portraitOverlay.updateHitbox();
		portraitOverlay.screenCenter();
		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		portraitOverlay.visible = true);
	}
	else
		new FlxTimer().start(0.16, function(tmr:FlxTimer)
		portraitOverlay.visible = false);
}
function postCreate(){
	FlxG.cameras.add(camText, false);
	remove(grpSongs);
	for(i in iconArray) remove(i);

	bg.frames = Paths.getSparrowAtlas('menus/freeplay/mainbgAnimate');
	if(FlxG.save.data.freeplaything == 1){
		bg.frames = Paths.getSparrowAtlas('menus/freeplay/classicbgAnimate');

	}
	bg.animation.addByPrefix('animate', 'animate', 24, true);
	bg.animation.play('animate');
	bg.scale.set(2,2);
	bg.screenCenter();

	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(490,-20),Paths.image('menus/freeplay/bar')));

	insert(5,portraitOverlay);
	scoreBG.alpha = 0.3;
	
	for (i in 0...iconArray2.length) add(iconArray2[i]);
	for (i in songs){
		var graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + i.name));
		graphic.persist = true;
		preload.push(graphic);
	}
	changeSelection(0, true);
	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	camText.addShader(fish = new CustomShader("fisheye"));
	fish.MAX_POWER = 0.2;
	var coolemitter = new FlxTypedEmitter();
	coolemitter.velocity.set(0, -5, 0, -10);
	coolemitter.y = FlxG.height;

	var coolzemitter = new FlxTypedEmitter();
	coolzemitter.velocity.set(0, 5, 0, 10);

	for (i in 0...150)
	{
		var p = new FlxParticle().makeGraphic(6,6,FlxColor.BLACK);
		var p2 = new FlxParticle().makeGraphic(12,12,FlxColor.BLACK);

		coolemitter.add(p);
		coolemitter.add(p2);
		coolzemitter.add(p);
		coolzemitter.add(p2);
	}
	for(i in [coolzemitter,coolemitter]){
		i.width = FlxG.width*1.5;
		i.angularVelocity.set(-10, 10);
		i.lifespan.set(5);
		add(i).start(false, 0.05);
	}
}
function onChangeSelection(event){
	if (event.change == 0) event.playMenuSFX = false;
	FlxTween.globalManager.completeTweensOf(portrait);
	var val = event.value;
	//I_know_this_is_dumb_but_dont_know_how_to_do_it_in_a_NON-dumb_way
	FlxTween.tween(scoreText,{y: scoreText.y + 0},0.00000000000000001,{onComplete:function(twn:FlxTween){
		curSelectReal[FlxG.save.data.freeplaything]=curSelected;
		var bullShit:Int = 0;
		for (i in grpSongs2){
				i.targetY = bullShit - curSelected;
				bullShit++;
				i.alpha = 0.6;
				if (i.targetY == 0) i.alpha = 1;
			}
		for (i in 0...iconArray2.length) iconArray2[i].alpha = 0.6;
	    iconArray2[curSelected].alpha = 1;
			shadering();}});
	FlxTween.tween(portrait,{y: portrait.y + 45,angle: 5},0.2,{ease:FlxEase.quintIn, onComplete:function(twn:FlxTween){
		portrait.loadGraphic(preload[val]);
		portrait.screenCenter();
		var mfwY = portrait.y;
		portrait.y -= 20;
		portrait.angle = -5;
		FlxTween.tween(portrait, {y: mfwY, angle: 0}, 0.4, {ease: FlxEase.elasticOut});
	}});
}
public static function lerpFix(value:Float) return value / (60 / 60);