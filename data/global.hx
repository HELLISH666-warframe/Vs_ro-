import funkin.backend.system.framerate.Framerate;
import openfl.text.TextFormat;
import lime.graphics.Image;
allowGitaroo = false;
var addedFPSshit:Bool = false;

var stateQuotes:Map<String, String> = [
    "DesktopState" => "In the desktop",
    "CreditsRon" => "Looking at Credits",
    "FreeplayState" => "In the Menus",
    "OptionsMenu" => "Options Menu",
    "Chart Editor" => "Freeplay Menu"
];

function new() {   
    FlxG.save.data.glitch ??= true;
    FlxG.save.data.chrom ??= true;
    FlxG.save.data.chromeOffset ??= 0.5;
    FlxG.save.data.mosaic ??= true;
    FlxG.save.data.crt ??= true;
    FlxG.save.data.colour ??= true;
    FlxG.save.data.grey ??= true;
    FlxG.save.data.vhs ??= true;
    FlxG.save.data.rain ??= true;
    FlxG.save.data.god ??= true;
    FlxG.save.data.rtx ??= false;

    FlxG.save.data.warning ??= true;
    FlxG.save.data.show_user_name ??= false;

    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Assets.getBitmapData(Paths.image('cursor')),1,1,1);
    FlxG.mouse.visible = false;
}

import funkin.backend.system.Flags;
Flags.DISABLE_WARNING_SCREEN=!FlxG.save.data.warning;
public static var chromeOffset = (FlxG.save.data.chromeOffset/350);
//thank_you_frakits_i_had_NO_idea_this_was_possible
function update(elapsed:Float)
if (FlxG.keys.justPressed.F8) {
FlxG.bitmap.clearCache();
FlxG.bitmap._cache.clear();
Paths.tempFramesCache.clear();
FlxG.resetState();
}
function postStateSwitch() {
    if (!addedFPSshit) {
        Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('w95.otf')), 18, -1);
        Framerate.fpsCounter.fpsLabel.defaultTextFormat = Framerate.memoryCounter.memoryText.defaultTextFormat = Framerate.memoryCounter.memoryPeakText.defaultTextFormat = Framerate.codenameBuildField.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('w95.otf')), 12, -1);
        addedFPSshit = true;
    }
}

function destroy(){
    FlxG.mouse.useSystemCursor = true;
    FlxG.mouse.visible = false;
    Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(Framerate.fontName, 18, -1);
    Framerate.fpsCounter.fpsLabel.defaultTextFormat = Framerate.memoryCounter.memoryText.defaultTextFormat = Framerate.memoryCounter.memoryPeakText.defaultTextFormat = Framerate.codenameBuildField.defaultTextFormat = Framerate.textFormat;
}