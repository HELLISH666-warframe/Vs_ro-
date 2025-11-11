//This DESPRATELYYLYLY needs tweaks , ok?
import funkin.backend.utils.FlxInterpolateColor;
import funkin.backend.utils.MathUtil;
import flixel.graphics.FlxGraphic;
import funkin.backend.chart.Chart;
import Alphabetthing;

var grpSongs = new FlxTypedGroup();
var iconArray:Array<HealthIcon> = [];

songs = [];
songRealList = [["ron","wasted","ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding"]];

for(s in songRealList[FlxG.save.data.freeplaything]) songs.push(Chart.loadChartMeta(s, "hard", true));

var scoreBG:FlxSprite;
var scoreText:FlxText;
var diffText:FlxText;
var coopText:FlxText;

var lerpScore:Float = 0;
var intendedScore:Int = 0;
import funkin.backend.utils.TranslationUtil as TU;
var TEXT_FREEPLAY_SCORE = TU.getRaw("freeplay.score");

var coopLabels:Array<String> = [
	TU.translate("freeplay.solo"),
	TU.translate("freeplay.opponentMode"),
	TU.translate("freeplay.coopMode"),
	TU.translate("freeplay.coopModeSwitched")
];

static var curSelectReal = [0,0,0];
static var curSelectedFP:Int = 0;
var curDifficulty:Int = 0;
var curCoopMode:Int = 0;

var portrait = new FlxSprite();
var portraitOverlay:FlxSprite = new FlxSprite();

var preload = [];

static var prevSong:String = "balls";
var camText = new FlxCamera();
camText.bgColor = null;

var bg:FlxSprite = new FlxSprite();

var time = 0;
var crt = new CustomShader("fake CRT");
var chrom = new CustomShader("chromatic aberration");
var fish = new CustomShader("fisheye");
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

var interpColor:FlxInterpolateColor;
 
function create() {
	CoolUtil.playMenuSong();
	FlxG.cameras.add(camText, false);

	if(FlxG.save.data.freeplaything == 1){
		bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(0,0),Paths.image('menus/freeplay/classicbgAnimate'));
		FlxG.camera.addShader(vhs);
	} else bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(0,0),Paths.image('menus/freeplay/mainbgAnimate'));
	bg.screenCenter();
	add(bg).scale.set(2,2);

	add(portrait);
	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(488,-20),Paths.image('menus/freeplay/bar')));
	add(portraitOverlay);
		
	add(grpSongs);
	for (i in 0...songs.length){
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

	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt);
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	camText.addShader(fish);
	fish.MAX_POWER = 0.2;

	scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
	scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, 'right');

	scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 1, 0xFF000000);
	scoreBG.alpha = 0.6;
	add(scoreBG);

	diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
	diffText.font = scoreText.font;
	add(diffText);

	coopText = new FlxText(diffText.x, diffText.y + diffText.height + 2, 0, "", 24);
	coopText.font = scoreText.font;
	add(coopText);

	add(scoreText);

	curSelectedFP=curSelectReal[FlxG.save.data.freeplaything];
	//if (curSelectedFP >= songs.length) curSelectedFP = 0;

	for (i in songs){
		Assets.exists(Paths.image('menus/freeplay/portraits/' + i.name)) ? port=i.name : port="ron";
		var graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + port));
		graphic.persist = true;
		preload.push(graphic);
	}
	interpColor = new FlxInterpolateColor(bg.color);

	changeSelection(0);
	changeDiff(0);
	changeCoopMode(0);
}

static var curPlayingInst = Paths.inst(songs[curSelectedFP].name, songs[curSelectedFP].difficulties[curDifficulty]);

function update(elapsed:Float) {time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	vhs.data.iTime.value = glitch.data.iTime.value = [time];

	lerpScore = lerp(lerpScore, intendedScore, 0.4);

	if (Math.abs(lerpScore - intendedScore) <= 10)
		lerpScore = intendedScore;

	for (i in 0...songs.length) grpSongs.members[i].y += (Math.sin(i+time)/2);
	for (item in grpSongs.members)
		item.forceX = FlxMath.lerp(item.x, 125 + (65 * (item.ID - curSelectedFP)),lerpFix(0.1));
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;

	for (i in 0...grpSongs.length)
		iconArray[i].setPosition(grpSongs.members[i].x+grpSongs.members[i].width+10,grpSongs.members[i].y-55);

	if (controls.LEFT_P||controls.RIGHT_P) changeDiff(controls.LEFT_P ? -1 : 1);
	if (controls.UP_P||controls.DOWN_P){
		changeSelection(controls.DOWN_P ? 1 : -1);
		changeDiff(0);
	}
	changeCoopMode((FlxG.keys.justPressed.TAB ? 1 : 0)); // TODO: make this configurable
	if (controls.BACK) {
		CoolUtil.playMenuSFX('CANCEL', 0.7);
		FlxG.switchState(new ModState('MasterFreeplayState'));
	}
	if (controls.ACCEPT){
		prevSong="FUCK";
		PlayState.loadSong(songs[curSelectedFP].name, songs[curSelectedFP].difficulties[curDifficulty].toLowerCase());
		FlxG.switchState(new PlayState());
	}

	scoreText.text = TEXT_FREEPLAY_SCORE.format([Math.round(lerpScore)]);
	scoreBG.scale.set(MathUtil.maxSmart(diffText.width, scoreText.width, coopText.width) + 8, (coopText.visible ? coopText.y + coopText.height : 66));
	scoreBG.updateHitbox();
	scoreBG.x = FlxG.width - scoreBG.width;

	scoreText.x = coopText.x = scoreBG.x + 4;
	diffText.x = Std.int(scoreBG.x + ((scoreBG.width - diffText.width) / 2));
	interpColor.fpsLerpTo(songs[curSelectedFP].color, 0.0625);
	bg.color = interpColor.color;
}

function changeCoopMode(change:Int = 0, force:Bool = false) {
	if (change == 0 && !force) return;
	if (!songs[curSelectedFP].coopAllowed && !songs[curSelectedFP].opponentModeAllowed) return;

	var bothEnabled = songs[curSelectedFP].coopAllowed && songs[curSelectedFP].opponentModeAllowed;

	curCoopMode = FlxMath.wrap(curCoopMode + change, 0, bothEnabled ? 3 : 1);

	updateScore();

	var key = "[TAB] "; // TODO: make this configurable

	if (bothEnabled) {
		coopText.text = key + coopLabels[curCoopMode];
	} else {
		coopText.text = key + coopLabels[curCoopMode * (songs[curSelectedFP].coopAllowed ? 2 : 1)];
	}
}

function changeSelection(change:Int = 0, playSound:Bool = true){
	if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	curSelectedFP = FlxMath.wrap(curSelectedFP + change, 0, songs.length-1);
	curSelectReal[FlxG.save.data.freeplaything]=curSelectedFP;

	FlxTween.globalManager.completeTweensOf(portrait);
	portrait.screenCenter(FlxAxes.Y);

	FlxTween.tween(portrait, {y: portrait.y + 45}, 0.2, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween) {
		updateportrait();
		var mfwY = portrait.y;
		portrait.y -= 20;
		FlxTween.tween(portrait, {y: mfwY}, 0.4, {ease: FlxEase.elasticOut});
	}});
	shadering();

	var bullShit:Int = 0;
	for (i in grpSongs){
		i.targetY = bullShit - curSelectedFP;
		bullShit++;
		i.alpha = 0.6;
		if (i.targetY == 0) i.alpha = 1;
	}
	for (i in 0...iconArray.length) iconArray[i].alpha = 0.6;
	  iconArray[curSelectedFP].alpha = 1;

	curPlayingInst = Paths.inst(songs[curSelectedFP].name, songs[curSelectedFP].difficulties[curDifficulty]);
	trace(prevSong);
	if(curPlayingInst!=prevSong){
		FlxG.sound.playMusic(curPlayingInst, 1);
		prevSong=curPlayingInst;
	}
}

function changeDiff(change:Int = 0) {
	curDifficulty = FlxMath.wrap(curDifficulty + change, 0, songs[curSelectedFP].difficulties.length-1);
	diffText.text ='<'+ songs[curSelectedFP].difficulties[curDifficulty].toUpperCase()+'>';
	songs[curSelectedFP].displayName=="Bleeding" ? diffText.color=0xE00020 : diffText.color=0xFFFFFFFF;
}

var __opponentMode:Bool = false;
var __coopMode:Bool = false;

function updateCoopModes() {
	__opponentMode = false;
	__coopMode = false;
	var curSong = songs[curSelectedFP];
	if (curSong.coopAllowed && curSong.opponentModeAllowed) {
		__opponentMode = curCoopMode % 2 == 1;
		__coopMode = curCoopMode >= 2;
	} else if (curSong.coopAllowed) {
		__coopMode = curCoopMode == 1;
	} else if (curSong.opponentModeAllowed) {
		__opponentMode = curCoopMode == 1;
	}
}

import funkin.savedata.FunkinSave;
function updateScore() {
	if (songs[curSelectedFP].difficulties.length <= 0) {
		intendedScore = 0;
		return;
	}
	updateCoopModes();
	var changes:Array<HighscoreChange> = [];
	if (__coopMode) changes.push(CCoopMode);
	if (__opponentMode) changes.push(COpponentMode);
	var saveData = FunkinSave.getSongHighscore(songs[curSelectedFP].name, songs[curSelectedFP].difficulties[curDifficulty]);
	intendedScore = saveData.score;
	trace(saveData.score);
}

function updateportrait() {
	portrait.loadGraphic(preload[curSelectedFP]);
	portrait.screenCenter();
		
	if (Assets.exists(Paths.image('menus/freeplay/portraits/'+songs[curSelectedFP]+'-over'))) {
		portraitOverlay.loadGraphic(Paths.image('freeplayportraits/'+songs[curSelectedFP]+'-over'));
		portraitOverlay.updateHitbox();
		portraitOverlay.visible = true;
	}
	else portraitOverlay.visible = false;
}

function shadering() {
	glitch.on = 0;
	FlxG.camera.removeShader(grey);
	trace(songs[curSelectedFP].displayName);
	switch (songs[curSelectedFP].displayName){
		case "trojan-virus" | "bleeding":
			glitch.on = 1.;
		case "gron":
			FlxG.camera.addShader(grey);
	}
}

function playSong() {
	glitch.on = 0;
	FlxG.camera.removeShader(grey);
	trace(songs[curSelectedFP].displayName);
	switch (songs[curSelectedFP].displayName){
		case "trojan-virus" | "bleeding":
			glitch.on = 1.;
		case "gron":
			FlxG.camera.addShader(grey);
	}
}

public static function lerpFix(value:Float) return value / (60 / 60);