import funkin.backend.utils.DiscordUtil;
var chrom = new CustomShader("chromatic aberration");
var crt = new CustomShader("fake CRT");
var color = new CustomShader("colorizer");
function postCreate() {
	CoolUtil.loadAnimatedGraphic(members[0], Paths.image("menus/freeplay/mainbgAnimate"));
	members[0].scale.set(2,2);
	members[0].updateHitbox();
	members[0].screenCenter();
	members[0].color = FlxColor.YELLOW;
	if (FlxG.save.data.crt) FlxG.camera.addShader(crt);
	if (FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
	chrom.rOffset=chromeOffset/2;
	chrom.bOffset=chromeOffset * -1;
	FlxG.camera.addShader(color);
	DiscordUtil.changePresenceSince("Options Menu", null);
	FlxG.mouse.useSystemCursor = false;
}