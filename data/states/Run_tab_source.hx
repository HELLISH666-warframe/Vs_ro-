//Splitting_the_runtab_in_parts.
import flixel.ui.FlxButton;
import funkin.editors.ui.UITextBox;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import funkin.editors.ui.UIState;
//class Run_tab_source extends UIState{
var tab:FlxSprite;
var t = Paths.getSparrowAtlas("menus/windowsUi/run tab");

var field:UITextBox;

var KILLYOURSELF:UITextBox;
var camPause = new FlxCamera();

function create() {
	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
	tab = new FlxSprite(0, 560);
	tab.frames = t;
	tab.animation.addByPrefix("d", "tab");
	tab.animation.play("d");
	add(tab); //270 text field length

	KILLYOURSELF = new UITextBox(435, 220, '', 410, 44, false);
    KILLYOURSELF.multiline = false;
	KILLYOURSELF.label.setFormat(Paths.font('vcr.ttf'), 30, FlxColor.WHITE);

	KILLYOURSELF.caretSpr.color = FlxColor.BLACK;
    FlxG.state.add(KILLYOURSELF);

	ok = new FlxButton(177, 685, "", function() {
		if(KILLYOURSELF.text!=null)
		triggerRunEvent(KILLYOURSELF.label.text);
		trace(KILLYOURSELF.label.text);
		//destroy();
	});
	cancel = new FlxButton(258, 685, "", function() {
		close();
	});
	help = new FlxButton(308, 566, "", function() {
		CoolUtil.browserLoad("www.facebook.com");
	});
	exit = new FlxButton(327, 566, "", cancel.onUp.callback);

	for (i=>button in [ok, cancel, help, exit]) {
		button.frames = t;
		var animIndex = ["ok", "cancel", "help", "exit"];
		button.animation.addByPrefix("normal", animIndex[i] + " neutral");
		button.animation.addByPrefix("highlight", animIndex[i] + " neutral");
		button.animation.addByPrefix("pressed", animIndex[i] + " pressed");
		button.updateHitbox();
		add(button);
	}
	help.setSize(15,13);
	exit.setSize(15,13);

	tabBar = new FlxButton(0, 560, "");
	tabBar.width = 347;
	tabBar.height = 20;
	tabBar.alpha = 0;
	tabBar.allowSwiping = true;
	add(tabBar);

}

function update() {
    if (controls.ACCEPT) {
        switch(KILLYOURSELF.label.text) {
            case "teevee": CoolUtil.browserLoad("https://youtu.be/X9hIJDzo9m0");
		    case "ron": #if windows Sys.command("start RON.exe"); #end
		    case "full" | "full version" | "2.5" | "3.0" | "demo 3" | "next demo": CoolUtil.browserLoad("https://youtu.be/pNzGTCEmf3U");
		    case "2012": 
			    rainbowscreen.visible = false;
			    FlxG.sound.play(Paths.sound('vine'));
		    case "winver": FlxG.state.add(new Winver());
		    case "cdplayer": FlxG.state.add(new MusicPlayer());
			FlxG.sound.music.volume = 0.01;
		    case "passionatedevs": ClientPrefs.rtxMode = !ClientPrefs.rtxMode;
		    //default: if (runText.contains("www") || runText.contains("http") || runText.contains("com")) CoolUtil.browserLoad(runText);
        }
    }
	if (FlxG.mouse.overlaps(KILLYOURSELF.label)) {
		trace("DFUHGHIURHJGREREGBHFBDHJEGRBJHF");
	}
}
//}