import hxvlc.flixel.FlxVideoSprite;

var tb:UITextBox;
var camPause = new FlxCamera();

function create() {
	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
	FlxG.sound.music.fadeOut(0.1, 0);

	var video = new FlxVideoSprite();
	video.load(Assets.getPath(Paths.video("ron")));
	video.camera=camPause;
	add(video).play();
	video.bitmap.onEndReached.add(function(){
	PlayState.loadWeek({
		songs: [{name: 'ron'}, {name: 'wasted'}, {name: 'ayo'}, {name: 'bloodshed'}, {name: 'trojan-virus'},]
		}, "hard");
	PlayState.isStoryMode=true;
	FlxG.switchState(new PlayState());
	});
}