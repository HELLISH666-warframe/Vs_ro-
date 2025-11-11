import flixel.ui.FlxButton;
import funkin.editors.ui.UITextBox;
import funkin.editors.ui.UISoftcodedWindow;
class Run_tab_source extends UISoftcodedWindow{
	public var tab:FlxSprite;
	public var t = Paths.getSparrowAtlas("menus/windowsUi/run tab");
	public var field:UITextBox;

	var camPause = new FlxCamera();

	var list = [
    	'shuck' => ['song', 'shucks'],
    	'poop' => ['image'],
    	'aetho' => ['video', 470, 50, 1.62, 0.8],
    	'marvin mode' => ['marvinMode']
	];
	var tb:UITextBox;
	//updateButton = ()->trace("KYS");
	public function new() {
		super();
		trace("DIE.");
		tab = new FlxSprite(0, 560);
		tab.frames = t;
		tab.animation.addByPrefix("d", "tab");
		tab.animation.play("d");
		add(tab); //270 text field length

		tb = new UITextBox(10,10, "FUCK", 276);
		tb.antialiasing = true;
		add(tb);
	}
	public override function create() {
	trace("jerhegur");
	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
	trace("Works.");

	/*tb.caretSpr.offset.set(0, -14);
    FlxG.state.add(tb).camera=camPause;*/

	ok = new FlxButton(177, 685, "", function() {
		if(tb.text!=null)
		triggerRunEvent(tb.label.text);
		trace(tb.label.text);
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
        var t = list[tb.label.text];
        if (t != null) {
            switch(t[0]) {
                case 'song':
                    PlayState.loadSong(t[1], 'hard');
                    FlxG.switchState(new PlayState());

                case 'image':
                    tb.selectable = false;
                    shit.alpha = 1;
                    shit.loadGraphic(Paths.image('menus/code/shitpost/' + tb.label.text));
                    new FlxTimer().start(1, function(t:FlxTimer) {
                        FlxTween.tween(shit, {alpha: 0}, 2.5, {ease: FlxEase.circOut, onComplete: function(t:FlxTween) {tb.selectable = true;}});
                    });
            }
        }
    }
	if (FlxG.mouse.overlaps(tb.label)) {
		trace("DFUHGHIURHJGREREGBHFBDHJEGRBJHF");
	}
	if (controls.UP_P) {FlxG.switchState(new ModState('DIE_FUCKER'));
	}
}
function triggerRunEvent(runText:String) {
	var enteredPassword:String = tb.label.text;
	switch (runText) {
		case "teevee": CoolUtil.browserLoad("https://youtu.be/X9hIJDzo9m0");
		case "ron": #if windows Sys.command("start RON.exe"); #end
		case "full" | "full version" | "2.5" | "3.0" | "demo 3" | "next demo": CoolUtil.browserLoad("https://youtu.be/pNzGTCEmf3U");
		case "2012": 
			rainbowscreen.visible = false;
			FlxG.sound.play(Paths.sound('vine'));
		case "winver": FlxG.state.add(new Winver());
		case "cdplayer": 	FlxG.state.add(new MusicPlayer());
							FlxG.sound.music.volume = 0.01;
		case "passionatedevs": ClientPrefs.rtxMode = !ClientPrefs.rtxMode;
		//default: if (runText.contains("www") || runText.contains("http") || runText.contains("com")) CoolUtil.browserLoad(runText);
	}
}
}