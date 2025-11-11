function postCreate(){
    gmod.setGraphicSize(Std.int(gmod.width * 0.34));
    gmod.updateHitbox();
    farm.setGraphicSize(Std.int(farm.width * 0.9));
    farm.updateHitbox();
    var cornBagrare:FlxSprite = new FlxSprite(1100,500).loadGraphic(Paths.image('stages/farm/popeye'));
	if (FlxG.random.int(1, 2) == 1)
        insert(12, cornBagrare);
}