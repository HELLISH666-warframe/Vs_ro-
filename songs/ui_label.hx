import flixel.text.FlxTextBorderStyle;
if (StringTools.endsWith(curSong, "classic")||(curSong == 'slammed' || curSong == 'holy-shit-dave-fnf')){
	add(kadeshit = new FlxText(20, FlxG.height * 0.9 +50, 0, curSong+" - Hard | ")).camera = camHUD;
	var swordEngine = (["Tristan","Dave","Bambi"])[Math.floor(Math.random()*3)];
	kadeshit.text += StringTools.endsWith(curSong, "classic") ? "KE 1.5.4 (ron eidtion)" : swordEngine + " Engine (KE 1.2)";
	StringTools.endsWith(curSong, "classic") ? 
	kadeshit.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE,FlxColor.BLACK) : kadeshit.setFormat(Paths.font("comic.ttf"), 16,  FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
}