import Sys;
import funkin.options.OptionsMenu;
import funkin.editors.charter.Charter;
import funkin.options.keybinds.KeybindsOptions;
import funkin.backend.utils.FunkinParentDisabler;

var optionArray = ["resume song","restart song","settings","shut down","log off"];
var settingsArray = ["Change binds","Change options"];
var curSelected = 0;
var subcurSelected = 0;
var menu = 0;
var optionButtons = [];
var suboptionButtons = [];
var pauseMusic = FlxG.sound.load(Paths.music('breakfast'), 0, true);
var bit = new CustomShader("8bitcolor");
var camPause = new FlxCamera();
function postCreate(){
	add(parentDisabler = new FunkinParentDisabler());

	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
    
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	var startMenu = new FlxSprite(0, 720).loadGraphic(Paths.image("windowsUi/start menu"));
	startMenu.y -= startMenu.height;
	add(startMenu);
	for (i in 0...optionArray.length) {
		var button = new FlxSprite(25, (723 - startMenu.height) + (34 * i) + (i > 1 ? 120 : 0)+ if(i > 2) 115);
		button.frames = Paths.getSparrowAtlas("windowsUi/win98buttons_plus");
		button.animation.addByPrefix("unselect", optionArray[i] + " unselect");
		button.animation.addByPrefix("select", optionArray[i] + " select");
		button.ID = i;
		add(button);
		button.animation.play("unselect");
		optionButtons.push(button);
	}

	for (i in 0...settingsArray.length) {
		var button = new FlxSprite(194, (498) + (25 * i));
		button.frames = Paths.getSparrowAtlas("windowsUi/win98buttons_plus");
		button.animation.addByPrefix("unselect", settingsArray[i] + " unselect");
		button.animation.addByPrefix("select", settingsArray[i] + " select");
		button.ID = i;
		add(button);
		button.animation.play("unselect");
		suboptionButtons.push(button);
	}
	suboptionButtons[0].alpha=0;
	suboptionButtons[1].alpha=0;
	cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	if (FlxG.save.data.colour){FlxG.camera.addShader(bit);
		PlayState.instance.camHUD.addShader(bit);
		bit.enablethisbitch = 1.;}
}
function update(elapsed:Float) {
	if (pauseMusic.volume < .5) pauseMusic.volume += elapsed * .01;
	if (FlxG.keys.justPressed.C) openSubState(new KeybindsOptions());
	for (i in optionButtons) {
		if (i.ID == curSelected) i.animation.play("select");
		else i.animation.play("unselect");
	}
	for (i in suboptionButtons) {
		if (i.ID == subcurSelected) i.animation.play("select");
		else i.animation.play("unselect");
	}
	if (controls.ACCEPT)accept();
	if (controls.BACK&&menu==1){menu=0;
	suboptionButtons[0].alpha=0;
	suboptionButtons[1].alpha=0;
	}
	if (controls.UP_P) changeOption(-1);
    if (controls.DOWN_P) changeOption(1);
    /*if (controls.DOWN_P){curSelected += 1; FlxG.sound.play(Paths.sound('scrollFunny'), 0.6);}
    if (controls.UP_P) {curSelected -= 1; FlxG.sound.play(Paths.sound('scrollFunny'), 0.6);}*/
    curSelected = (curSelected > optionArray.length - 1 ? 0 : (curSelected < 0 ? optionArray.length - 1 : curSelected));
	if (FlxG.keys.justPressed.O)FlxG.camera.removeShader(bit);
}
function destroy(){
	PlayState.instance.camHUD.removeShader(bit);
    FlxG.camera.removeShader(bit);
    FlxG.sound.destroySound(pauseMusic);
	FlxG.cameras.remove(camPause);
}
function changeOption(p) {
	if(menu==0)curSelected = FlxMath.wrap(curSelected + p, 0, 4);
	else
		subcurSelected = FlxMath.wrap(subcurSelected + p, 0, 1);
}
function accept(){
	if (menu==0) {
	for (i in optionButtons) {
        switch (optionArray[i.ID]){
			case "resume song": close();
			case "restart song": FlxG.resetState();
			//TODO make settings open a submenu like in windows 95.
			case "settings": menu=1;
			suboptionButtons[0].alpha=1;
	        suboptionButtons[1].alpha=1;
			case "shut down":openSubState(new ModSubState("shut-down"));
			case "log off":
				PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;
				if (PlayState.chartingMode && Charter.undos.unsaved) PlayState.instance.saveWarn(false);
				else if(PlayState.isStoryMode) FlxG.switchState(new ModState("DesktopState"));
				else FlxG.switchState(new FreeplayState());
			}
		}
	}
	if (menu==1) {
	for (i in suboptionButtons) {
        switch (settingsArray[i.ID]){
			case "Change binds": openSubState(new KeybindsOptions());
			case "Change options": FlxG.switchState(new OptionsMenu((_) -> FlxG.switchState(new PlayState())));
		}
		}
	}
}