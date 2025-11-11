import Alphabetthing;
import flixel.graphics.FlxGraphic;
import funkin.backend.chart.Chart;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;
var time = 0;
var crt = new CustomShader("fake CRT");
var chrom = new CustomShader("chromatic aberration");
var fish = new CustomShader("fisheye");
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

songs = [];
songRealList = [["ron","wasted","ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding","ron-bside","wasted-bside"]];
modelist = ["MAIN","CLASSIC","EXTRAS"];

for(s in songRealList[FlxG.save.data.freeplaything]) songs.push(Chart.loadChartMeta(s, "hard", true));
var camText = new FlxCamera();
camText.bgColor = null;
var portrait = new FlxSprite();
var portraitOverlay = new FlxSprite();
var preload = [];
var grpSongs = new FlxTypedGroup();
var iconArray:Array<HealthIcon> = [];
var modeText = new FlxText(0,0,0,modelist[FlxG.save.data.freeplaything],0);
modeText.setFormat(Paths.font("w95.otf"),48,FlxColor.WHITE);
static var curSelectReal = [0,0,0];
var curSelect = 0;
var curDifficulty:Int = 1;
var bg:FlxSprite= new FlxSprite(0,0);

function create() {
	if(FlxG.save.data.freeplaything == 1){
		bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(0,0),Paths.image('menus/freeplay/classicbgAnimate'));
		FlxG.camera.addShader(vhs);
	} else bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(0,0),Paths.image('menus/freeplay/mainbgAnimate'));
	bg.scale.set(2,2);
	bg.screenCenter();
	add(bg);
	add(grpSongs);
	for (i in 0...songs.length) {
		var songText = new Alphabetthing(0, (70 * i) + 30, songs[i].displayName, true, false);
		songText.isMenuItem = true;
		songText.targetY = i;
		songText.ID = i;
		songText.camera = camText;
		grpSongs.add(songText);
		var icon = new HealthIcon(songs[i].icon);
		iconArray.push(icon);
		add(icon);
	}
	for (i in 0...iconArray.length) remove(iconArray[i]);
	curSelect=curSelectReal[FlxG.save.data.freeplaything];
	add(modeText);
	add(portrait).updateHitbox();

	FlxG.cameras.add(camText, false);

	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(488,-20),Paths.image('menus/freeplay/bar')));
	add(portraitOverlay);
	for (i in 0...iconArray.length) add(iconArray[i]);

	for (i in songs){
		Assets.exists(Paths.image('menus/freeplay/portraits/' + i.name)) ? port=i.name : port="ron";
		var graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + port));
		graphic.persist = true;
		preload.push(graphic);
	}
	changeSelection(0);
	changeDiff(0);
	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt);
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	camText.addShader(fish);
	fish.MAX_POWER = 0.2;
	var coolemitter = new FlxTypedEmitter();
	coolemitter.velocity.set(0, -5, 0, -10);
	coolemitter.y = FlxG.height;

	var coolzemitter = new FlxTypedEmitter();
	coolzemitter.velocity.set(0, 5, 0, 10);

	for (i in 0...150) {
		var p = new FlxParticle().makeGraphic(6,6,FlxColor.BLACK);
		var p2 = new FlxParticle().makeGraphic(12,12,FlxColor.BLACK);

		coolemitter.add(p);
		coolemitter.add(p2);
		coolzemitter.add(p);
		coolzemitter.add(p2);
	}
	for(i in [coolzemitter,coolemitter]) {
		i.width = FlxG.width*1.5;
		i.angularVelocity.set(-10, 10);
		i.lifespan.set(5);
		add(i).start(false, 0.05);
	}
}
function update(elapsed:Float) {
	if (controls.LEFT_P||controls.RIGHT_P) changeDiff(controls.RIGHT_P ? 1 : -1);
	if (controls.UP_P||controls.DOWN_P){ changeSelection(controls.DOWN_P ? 1 : -1);
		changeDiff(0);
	}
	if (controls.BACK) FlxG.switchState(new ModState('MasterFreeplayState'));
	if (controls.ACCEPT) playSong();
}
function postUpdate(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	vhs.data.iTime.value = glitch.data.iTime.value = [time];
	for (i in 0...songs.length) grpSongs.members[i].y += (Math.sin(i+time)/2);
	for (item in grpSongs.members)
		item.forceX = FlxMath.lerp(item.x, 125 + (65 * (item.ID - curSelect)),lerpFix(0.1));
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;
	for (i in 0...grpSongs.length)
		iconArray[i].setPosition(grpSongs.members[i].x+grpSongs.members[i].width+10,grpSongs.members[i].y-55);
}

function updateportrait(){
	var cursong = songs[curSelect].displayName;
	FlxTween.tween(portrait,{y: portrait.y + 45,angle: 5},0.2,{ease:FlxEase.quintIn, onComplete:function(twn:FlxTween){
		portrait.loadGraphic(preload[curSelect]);
		portrait.screenCenter();
		var mfwY = portrait.y;
		portrait.y -= 20;
		portrait.angle = -5;
		FlxTween.tween(portrait, {y: mfwY, angle: 0}, 0.4, {ease: FlxEase.elasticOut});
		if (Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong+'-over'))) {
		portraitOverlay.loadGraphic(Paths.image('menus/freeplay/portraits/'+cursong+'-over'));
		portraitOverlay.updateHitbox();
		portraitOverlay.screenCenter();
		portraitOverlay.visible = true;
	} else
		portraitOverlay.visible = false;
	}});
    switch(cursong) {
		case"gron":if(FlxG.save.data.grey)FlxG.camera.addShader(grey);camText.addShader(grey);
		case"trojan-virus":glitch.on = 1.;
		case"Bleeding":/*diffText.color=0xE00020;*/glitch.on = 1.;
		default:FlxG.camera.removeShader(grey);camText.removeShader(grey);
		glitch.on = 0;//diffText.color=0xFFFFFFFF;
    }
}

function changeSelection(change:Int = 0, playSound:Bool = true){
	FlxTween.globalManager.completeTweensOf(portrait);
	curSelect = FlxMath.wrap(curSelect + change, 0, songs.length - 1);
	updateportrait();
	curSelectReal[FlxG.save.data.freeplaything]=curSelect;
	var bullShit:Int = 0;
	for (i in grpSongs){
		i.targetY = bullShit - curSelect;
		bullShit++;
		i.alpha = 0.6;
		if (i.targetY == 0) i.alpha = 1;
	}
	for (i in 0...iconArray.length) iconArray[i].alpha = 0.6;
	iconArray[curSelect].alpha = 1;
}

function changeDiff(p) {
	curDifficulty = FlxMath.wrap(curDifficulty + p, 0, songs[curSelect].difficulties.length-1);
	Assets.exists(Paths.image('menus/Extras/Freeplay/diffs/' + songs[curSelect].difficulties[curDifficulty])) ? port=songs[curSelect].difficulties[curDifficulty] : port="???";
}

function playSong(){
	prevSong="FUCK";
	PlayState.loadSong(songs[curSelect].name, songs[curSelect].difficulties[curDifficulty].toLowerCase());
	inFreeplay = false;
	FlxG.switchState(new PlayState());
}

public static function lerpFix(value:Float) return value / (60 / 60);