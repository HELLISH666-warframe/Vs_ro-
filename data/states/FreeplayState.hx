import flixel.effects.particles.FlxTypedEmitter;
import flixel.effects.particles.FlxParticle;
import funkin.backend.chart.Chart;
import flixel.graphics.FlxGraphic;
import Alphabetthing;

var time = 0;
var chrom = new CustomShader("chromatic aberration");
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

songs = [];
songRealList = [["ron","wasted","ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","trouble","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding"]];
modelist = ["MAIN","CLASSIC","EXTRAS"];

for(s in songRealList[FlxG.save.data.freeplaything]) songs.push(Chart.loadChartMeta(s, "hard", true));
var camText = new FlxCamera();
camText.bgColor = null;
var portrait = new FlxSprite();
var portraitOverlay = new FlxSprite();
var preload = [];
var grpSongs2 = new FlxTypedGroup();
var iconArray2:Array<HealthIcon> = [];
var modeText = new FlxText(0,0,0,modelist[FlxG.save.data.freeplaything]).setFormat(null,48,FlxColor.WHITE);
static var realShit = [[0,0,0],[null]];
function postUpdate(elapsed:Float){time += elapsed;
	if(controls.BACK)FlxG.switchState(new ModState('MasterFreeplayState'));
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	vhs.data.iTime.value = glitch.data.iTime.value = [time];

	for (i in 0...songs.length){grpSongs2.members[i].y += (Math.sin(i+time)/2);
		iconArray2[i].setPosition(grpSongs2.members[i].x+grpSongs2.members[i].width+10,grpSongs2.members[i].y-55);
	}
	for (item in grpSongs2.members)
		item.forceX = FlxMath.lerp(item.x, 125 + (65 * (item.ID - curSelected)),0.1 / (Options.framerate / 60));//Todo:MAKE_THIS_NOT_BREAK_ON_HIGH_FRAMERATES.
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;
}
function create(){
	add(grpSongs2);
	for (i in 0...songs.length) {
		var songText = new Alphabetthing(0, (70 * i) + 30, songs[i].displayName, true);
		songText.isMenuItem = true;
		songText.targetY = songText.ID = i;
		grpSongs2.add(songText).camera = camText;
		add(icon = new HealthIcon(songs[i].icon));
		iconArray2.push(icon);
	}
	for (i in 0...iconArray2.length) remove(iconArray2[i]);
	curSelected=realShit[0][FlxG.save.data.freeplaything];
	insert(2,modeText);
	insert(2,portrait).updateHitbox();
	curPlayingInst=realShit[1];
}
function postCreate(){
	FlxG.cameras.add(camText, false);
	remove(grpSongs);
	for(i in iconArray) remove(i);

	bg.frames = Paths.getSparrowAtlas('menus/freeplay/mainbgAnimate');
	if(FlxG.save.data.freeplaything == 1){
		bg.frames = Paths.getSparrowAtlas('menus/freeplay/classicbgAnimate');
		FlxG.camera.addShader(vhs);
	}
	bg.animation.addByPrefix('animate', 'animate', 24, true);
	bg.animation.play('animate');
	bg.scale.set(2,2);
	bg.screenCenter();

	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(490,-20),Paths.image('menus/freeplay/bar')));

	insert(5,portraitOverlay);
	for (i in members) if (Std.isOfType(i, FlxText)) i.font = Paths.font("w95.otf");
	scoreBG.alpha = 0.3;
	
	for (i in 0...iconArray2.length) add(iconArray2[i]);
	for (i in songs){
		preload.push(graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + i.name)));
		graphic.persist = true;
	}
	changeSelection(0, true);
	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	if(FlxG.save.data.grey){FlxG.camera.addShader(grey);camText.addShader(grey);}
	camText.addShader(fish = new CustomShader("fisheye"));
	fish.MAX_POWER = 0.2;

	var coolemitter = new FlxTypedEmitter(null,FlxG.height);
	coolemitter.velocity.set(0, -5, 0, -10);
	var coolzemitter = new FlxTypedEmitter();
	coolzemitter.velocity.set(0, 5, 0, 10);

	for (i in 0...150) {
		for(pratt in [coolemitter,coolzemitter]){
			pratt.add(p = new FlxParticle().makeGraphic(6,6,FlxColor.BLACK));
			pratt.add(p2 = new FlxParticle().makeGraphic(12,12,FlxColor.BLACK));
		}
	}
	for(i in [coolzemitter,coolemitter]){
		i.width = FlxG.width*1.5;
		i.angularVelocity.set(-10, 10);
		i.lifespan.set(5);
		add(i).start(false, 0.05);
	}
}
function shadering(?string:String=""){
	var cursong = songs[curSelected].displayName;
	if(string=="hand"){
		if(Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong+'-over')))
		portraitOverlay.loadGraphic(Paths.image('menus/freeplay/portraits/'+cursong+'-over'));
		portraitOverlay.screenCenter();
		Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong+'-over')) ? portraitOverlay.visible = true : 
		portraitOverlay.visible = false;
		return;
	}
    switch(cursong)	{
		case"gron":if(FlxG.save.data.grey)grey.enable=1;
		case"trojan-virus":glitch.on = 1.;
		case"Bleeding":diffText.color=0xE00020;glitch.on = 1.;
		default:grey.enable=0; glitch.on = 0;diffText.color=0xFFFFFFFF;
    }
}
function onChangeSelection(event){
	if (event.change == 0) event.playMenuSFX = false;
	FlxTween.globalManager.completeTweensOf(portrait);
	var val = event.value;
	//I_know_this_is_dumb_but_dont_know_how_to_do_it_in_a_NON-dumb_way
	new FlxTimer().start(0.000001, ()->{realShit[0][FlxG.save.data.freeplaything]=curSelected;
		for (i in grpSongs2){
			i.targetY = i.ID - curSelected;
			i.targetY == 0 ? i.alpha = 1 : i.alpha = 0.6;
		}

		for (i in 0...iconArray2.length) iconArray2[i].alpha = 0.6;
	    iconArray2[curSelected].alpha = 1;
		realShit[1]=Paths.inst(songs[curSelected].name, songs[curSelected].difficulties[curDifficulty]);
		shadering();});
	FlxTween.tween(portrait,{y: portrait.y + 45,angle: 5},0.2,{ease:FlxEase.quintIn, onComplete:function(twn:FlxTween){
		portrait.loadGraphic(preload[val]);
		shadering("hand");
		portrait.screenCenter();
		var mfwY = portrait.y;
		portrait.y -= 20;
		portrait.angle = -5;
		FlxTween.tween(portrait, {y: mfwY, angle: 0}, 0.4, {ease: FlxEase.elasticOut});
	}});
}