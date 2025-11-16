import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxStringUtil;
import flixel.ui.FlxBar;
public var timeTxt;
public var timeBarBG;
public var timeBar;
var songLength = FlxG.sound.music.length;
function create() {
    timeTxt = new FlxText(42 + (FlxG.width / 2) - 248, 19, 400,curSong);
	timeTxt.setFormat(Paths.font("w95.otf"), 32, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	timeTxt.scrollFactor.set();
	timeTxt.alpha = 1;
	timeTxt.borderSize = 2;

    timeBarBG = new FlxSprite().loadGraphic(Paths.image('timeBar'));
	timeBarBG.x = timeTxt.x;
	timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
	timeBarBG.scrollFactor.set();
	//timeBarBG.alpha = 0;
	//timeBarBG.visible = showTime;
	timeBarBG.color = FlxColor.BLACK;
	add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, 'LEFT_TO_RIGHT', Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), null, '', 0, 1);
	timeBar.scrollFactor.set();
	timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
	timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
	timeBar.alpha = 1;
	add(timeBar);
    add(timeTxt);
    for(i in [timeBar,timeTxt,timeBarBG]){i.camera=camHUD;
        if(curSong=='pretty-wacky')i.alpha=0;
    }
}

function update(elapsed:Float) {
    var songCalc:Float = (songLength - Conductor.songPosition);
    if(FlxG.save.data.TimeBar == "elapsed") songCalc = Conductor.songPosition;
	if(songCalc < 0) songCalc = 0;
    timeTxt.text = FlxStringUtil.formatTime(songCalc/1000, false);
    timeBar.percent = (Conductor.songPosition/songLength)*100;
}

/*
import flixel.ui.FlxBar;
var actualBar:FlxBar;

function postCreate()
{
    actualBar = new FlxBar(0, PlayState.downscroll ? 95 : 740, 'LEFT_TO_RIGHT', 908, 18);
    actualBar.cameras = [camHUD];
    actualBar.createGradientBar([0xFFFFFFFF, 0xFFFF0000], [0xFF48FF48, 0xFFFFFFFF], 1, 0);
    actualBar.updateBar();
    actualBar.screenCenter(FlxAxes.X);
    insert(members.indexOf(camHUD), actualBar);
    add(actualBar); 

    var barbg:FlxSprite = new FlxSprite(actualBar.x - 4, actualBar.y - 4);
    barbg.loadGraphic(Paths.image("stages/ffsonic/ui/healthbar_BG"));
    barbg.antialiasing = false;
    barbg.cameras = [camHUD];
    barbg.scale.set(2, 2);
    barbg.updateHitbox();
	insert(members.indexOf(camHUD), barbg);
    add(barbg);
}

override function update(elapsed:Float){
    actualBar.percent = (health / 2) * 100;
    FlxG.watch.addQuick('percent', actualBar.percent);
}*/