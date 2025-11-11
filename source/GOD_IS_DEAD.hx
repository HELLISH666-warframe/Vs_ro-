import I_want_to_stab_myself;

class GOD_IS_DEAD extends I_want_to_stab_myself {
	public var delay:Float = 0.05;
	public var paused:Bool = false;

	// for menu shit
	public var forceX:Float = Math.NEGATIVE_INFINITY;
	public var targetY:Float = 0;
	public var yMult:Float = 120;
	public var xAdd:Float = 0;
	public var yAdd:Float = 0;
	public var isMenuItem:Bool = false;
	public var textSize:Float = 1.0;

	public var text:String = "";

	public var trackingSpr:FlxSprite;
	public var autoOffset:Bool = true;

	var _finalText:String = "";
	var yMulti:Float = 1;

	// custom shit
	// amp, backslash, question mark, apostrophy, comma, angry faic, period
	var lastSprite:AlphaCharacter_plus;
	var xPosResetted:Bool = false;

	var splitWords:Array<String> = [];

	public var isBold:Bool = false;
	public var lettersArray:Array<AlphaCharacter_plus> = [];

	public var finishedText:Bool = false;
	public var typed:Bool = false;

	public var typingSpeed:Float = 0.05;
	public override function new(x:Float, y:Float, text:String = "", ?bold:Bool = false, typed:Bool = false, ?typingSpeed:Float = 0.05, ?textSize:Float = 1){
		super(x, y);
		forceX = Math.NEGATIVE_INFINITY;
		this.textSize = textSize;

		_finalText = text;
		this.text = text;
		this.typed = typed;
		isBold = bold;

		if (text != "")
		{
			if (typed)
			{
				startTypedText(typingSpeed);
			}
			else
			{
				addText();
			}
		} else {
			finishedText = true;
		}
	}
	public override function addText()
	{
		var xPos:Float = 0;
		for (character in splitWords)
		{
			var spaceChar:Bool = (character == " " || (isBold && character == "_"));
			if (spaceChar)
			{
				consecutiveSpaces++;
			}

			var isNumber:Bool = AlphaCharacter_plus.numbers.indexOf(character) != -1;
			var isSymbol:Bool = AlphaCharacter_plus.symbols.indexOf(character) != -1;
			var isAlphabet:Bool = AlphaCharacter_plus.alphabet.indexOf(character.toLowerCase()) != -1;
			if ((isAlphabet || isSymbol || isNumber) && (!isBold || !spaceChar))
			{
				if (lastSprite != null)
				{
					xPos = lastSprite.x + lastSprite.width;
				}

				if (consecutiveSpaces > 0)
				{
					xPos += 40 * consecutiveSpaces * textSize;
				}
				consecutiveSpaces = 0;

				// var letter:AlphaCharacter_plus = new AlphaCharacter_plus(30 * loopNum, 0, textSize);
				var letter:AlphaCharacter_plus = new AlphaCharacter_plus(xPos, 0, textSize);

				if (isBold)
				{
					if (isNumber)
					{
						letter.createBoldNumber(character);
					}
					else if (isSymbol)
					{
						letter.createBoldSymbol(character);
					}
					else
					{
						letter.createBoldLetter(character);
					}
				}
				else
				{
					if (isNumber)
					{
						letter.createNumber(character);
					}
					else if (isSymbol)
					{
						letter.createSymbol(character);
					}
					else
					{
						letter.createLetter(character);
					}
				}

				add(letter);
				lettersArray.push(letter);

				lastSprite = letter;
			}
		}
	}
	override function update(elapsed:Float)
	{
		if (trackingSpr != null) {
			trackingSpr.setPosition(forceX - (25 + trackingSpr.width), y + (height / 2) - (trackingSpr.height / 2));
		}
		if(forceX != Math.NEGATIVE_INFINITY) 
			x = forceX;
		var it:Int = 0;
		if (autoOffset)
			for (i in this.members) {
				if (it != 0 && i != null) i.offset.x = ((1 - i.scale.x) * 50) * it;
				it++;
			}
		if (isMenuItem)
		{
			var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);

			var lerpVal:Float = FlxMath.bound(elapsed * 8., 0, 1);
			y = FlxMath.lerp(y, (scaledY * yMult) + (FlxG.height * 0.48) + yAdd, lerpVal);
			if(forceX == Math.NEGATIVE_INFINITY) {
				x = FlxMath.lerp(x, (targetY * 20) + 90 + xAdd, lerpVal);
			}
		}

		super.update(elapsed);
	}
}