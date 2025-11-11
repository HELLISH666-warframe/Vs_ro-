import openfl.utils.AssetLibrary;
import haxe.xml.Access;
import funkin.backend.assets.LimeLibrarySymbol;
import funkin.backend.assets.IModsAssetLibrary;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import funkin.menus.ui.ClassicAlphabet.AlphaCharacter;
import funkin.menus.ui.ClassicAlphabet;
import AlphaCharacter_plus;
import Xml;

using StringTools;

class I_want_to_stab_myself {
	// for menu shit
	public var targetY:Float = 0;
	public var isMenuItem:Bool = false;

	public var text:String = "";

	var _finalText:String = "";
	var _curText:String = "";

	var yMulti:Float = 1;

	// custom shit
	// amp, backslash, question mark, apostrophy, comma, angry faic, period
	var lastSprite:AlphaCharacter_plus;
	var xPosResetted:Bool = false;

	var splitWords:Array<String> = [];

	var isBold:Bool = false;

	public function refreshAlphabetXML(path:String) {
		AlphaCharacter_plus.__alphaPath = Paths.getAssetsRoot() + path;
			/*var xml = new Access(Xml.parse(Assets.getText(path)).firstElement());
			AlphaCharacter_plus.boldAnims = [];
			AlphaCharacter_plus.letterAnims = [];
			AlphaCharacter_plus.boldAlphabetPath = AlphaCharacter_plus.letterAlphabetPath = 'ui/alphabet';

			for(e in xml.elements) {
			var bold = e.name == "bold";
			var list = bold ? AlphaCharacter_plus.boldAnims : AlphaCharacter_plus.letterAnims;
			if (e.has.spritesheet) {
				if (bold)
					AlphaCharacter_plus.boldAlphabetPath = e.att.spritesheet;
				else
					AlphaCharacter_plus.letterAlphabetPath = e.att.spritesheet;
			}
			for(e in e.nodes.letter) {
				if (!e.has.char || !e.has.anim) continue;
				var name = e.att.char;
				var anim = e.att.anim;
				list[name] = anim;
			}
		}*/
	}


	/*private override function set_color(c:Int):Int {
		for(e in group.members) {
			if (e is AlphaCharacter_plus) {
				var char = cast(e, AlphaCharacter_plus);
				char.setColor(c, isBold);
			}
		}
		return super.set_color(c);
	}
	*/
	public function new(x:Float, y:Float, text:String = "", ?bold:Bool = false, typed:Bool = false){
		//super(x, y);

		_finalText = this.text = text;
		isBold = bold;

		var alphabetPath = Paths.xml("alphabet");
		if (Paths.getAssetsRoot() + alphabetPath != AlphaCharacter_plus.__alphaPath) {
			refreshAlphabetXML(alphabetPath);
		}
		#if MOD_SUPPORT else {
			var libThing = new LimeLibrarySymbol(alphabetPath);
			if (libThing.library is AssetLibrary) {
				var library = cast(libThing.library, AssetLibrary);
				@:privateAccess
				if (library.__proxy != null && library.__proxy is AssetLibrary) {
					@:privateAccess
					library = cast(library.__proxy, AssetLibrary);
				}
				if (library is IModsAssetLibrary) {
					var modLib = cast(library, IModsAssetLibrary);
					@:privateAccess
					if (!modLib.__isCacheValid(library.cachedBytes, libThing.symbolName)) {
						refreshAlphabetXML(alphabetPath);
					}
				}
			}
		}
		#end

		if (text != "")
		{
			if (typed)
			{
				startTypedText();
			}
			else
			{
				addText();
			}
		}
	}

	public function addText()
	{
		//doSplitWords();

		var xPos:Float = 0;
		for (character in splitWords)
		{
			if (lastSprite != null)
				xPos = lastSprite.x + lastSprite.width - x;

			var letter:AlphaCharacter_plus = new AlphaCharacter_plus(xPos, 0);
			if (isBold)
				letter.createBold(character);
			else
				letter.createLetter(character);

			if (!letter.visible)
				xPos += 40;

			letter.setColor(color, isBold);
			add(letter);

			lastSprite = letter;
		}
	}

	/*
	function doSplitWords():Void
	{
		splitWords = _finalText.split("");
	}
	*/

	public function startTypedText():Void
	{
		_finalText = text;
		//doSplitWords();

		var loopNum:Int = 0;

		var xPos:Float = 0;
		var curRow:Int = 0;

		new FlxTimer().start(0.05, function(tmr:FlxTimer)
		{
			if (_finalText.fastCodeAt(loopNum) == "\n".code)
			{
				yMulti += 1;
				xPosResetted = true;
				xPos = 0;
				curRow += 1;
			}
			loopNum += 1;

			tmr.time = FlxG.random.float(0.04, 0.09);
		}, splitWords.length);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (isMenuItem)
		{
			var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

			y = CoolUtil.fpsLerp(y, (scaledY * 120) + (FlxG.height * 0.48), 0.16);
			x = CoolUtil.fpsLerp(x, (targetY * 20) + 90, 0.16);
		}

		if (text != _finalText) {
			_finalText = text;
			for(e in members)
				e.destroy();
			members.clear();
			lastSprite = null;
			addText();
		}
	}
}
