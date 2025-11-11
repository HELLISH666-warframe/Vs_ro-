import flixel.group.FlxSpriteGroup;
import funkin.menus.ui.ClassicAlphabet.AlphaCharacter;
import funkin.menus.ui.ClassicAlphabet;
class AlphaCharacter_plus extends AlphaCharacter
{

	public static var __alphaPath:String = null;

	public static var letterAlphabetPath:String;
	public static var boldAlphabetPath:String;

	public static var boldAnims:Map<String, String> = [];
	public static var letterAnims:Map<String, String> = [];

	public var row:Int = 0;

	public function createBold(letter:String)
	{
		if(!boldAnims.exists(letter))
			letter = letter.toUpperCase();
		if (!boldAnims.exists(letter)) {
			visible = false;
			active = false;
			scale.set();
			width = 40;
			return;
		}
		frames = Paths.getFrames(boldAlphabetPath);
		animation.addByPrefix(letter, boldAnims[letter], 24);
		animation.play(letter);
		updateHitbox();
	}
}