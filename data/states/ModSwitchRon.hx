import funkin.backend.assets.ModsFolder;
import haxe.io.Path;
import sys.FileSystem;
import flixel.group.FlxTypedSpriteGroup;

var mods:Array<String> = [];
var curSelected:Int = 0;

var subCam:FlxCamera;

var foldertext:FlxTypedGroup<FlxText>;
var folders:FlxTypedSpriteGroup<FlxSprite>;
var cunvrehgu = new CustomShader("fake CRT");
var hitbox:FlxSprite;

var folderCam = new FlxCamera();

var white:FlxSprite;

var third = new FlxCamera();

function create() {
	folderCam.bgColor = FlxColor.WHITE;
	FlxG.camera.bgColor = FlxColor.WHITE;
	camera = subCam = new FlxCamera();
	subCam.bgColor = 0;
	FlxG.cameras.add(subCam, false);
	FlxG.cameras.add(folderCam, false);
	FlxG.cameras.add(third, false);


	mods = ModsFolder.getModsList();
	mods.push(null);

	changeSelection(0, true);

	insert(0,white = new FlxSprite().loadGraphic(Paths.image('menus/remove_later/modswitch/white'))).camera=subCam;

	add(back = new FlxSprite().loadGraphic(Paths.image('menus/remove_later/modswitch/ewdfhbruihb'))).camera=third;
	white.setGraphicSize(2550,1400);
	white.scrollFactor.set(1,1);
	if(FlxG.save.data.show_user_name){
	#if WINDOWS
	window.title="Browsing "+Sys.environment()["USERNAME"]+"'s pc.";
	#else
	window.title="Browsing "+Sys.environment()["USER"]+"'s pc.";
	#end
	}else window.title="Browsing Ronald Mcslide's pc.";

	foldertext = new FlxTypedGroup<FlxText>();
	folders = new FlxTypedSpriteGroup<FlxSprite>();

	for (i in 0...mods.length) {
		var text = new FlxText(0,0,100,mods[i] ==null ?"disableMods": mods[i],20);
		text.setFormat(Paths.font("w95.otf"),17,FlxColor.BLACK,'center');
		text.ID = i;
		text.x =40+ 120 * (text.ID % 10);
		text.y = 140 +140 * Math.floor(text.ID / 10);
		//Credict_user_later.
		text.updateHitbox();
		foldertext.add(text).camera=folderCam;

		var folder = new FlxSprite().loadGraphic(Paths.image("menus/remove_later/modswitch/folder"));
		folder.setPosition(text.x+text.width-75,text.y-50);
		folder.setGraphicSize(50, 50);
		folder.updateHitbox();
		folder.ID = i;
		folders.add(folder).camera=folderCam;
	}
	add(foldertext);
    add(folders);

	add(hitbox = new FlxSprite(1246, 5).makeSolid(30, 14, 0xE0000020)).alpha = 0;
	hitbox.width=60;
	hitbox.height=60;

	if (FlxG.save.data.crt) subCam.addShader(cunvrehgu);
	if (FlxG.save.data.crt) folderCam.addShader(cunvrehgu);
	if (FlxG.save.data.crt) third.addShader(cunvrehgu);

	//subCam.zoom=0.2;
	//folderCam.zoom=0.2;
}
function update(elapsed:Float) {
	if (controls.ACCEPT) {
		ModsFolder.switchMod(mods[curSelected]);
		close();
	}
	if (controls.BACK) close();

	scrollCam(- FlxG.mouse.wheel);

	folders.forEach(function (folder) {
        if (FlxG.mouse.overlaps(folder)) {
            if (curSelected != folder.ID) {
                changeSelection(folder.ID-curSelected);
				trace(curSelected);
            }
            if (FlxG.mouse.justPressed){ModsFolder.switchMod(mods[curSelected]);
		    close();
			}
        }
    });
	if (FlxG.mouse.overlaps(hitbox) && FlxG.mouse.pressed) close();
	for(i in 0...folders.members.length)
	folders.members[i].updateHitbox();
}

function changeSelection(change:Int, force:Bool = false) {
	if (change == 0 && !force) return;
	curSelected = FlxMath.wrap(curSelected + change, 0, mods.length-1);
}

function scrollCam(change:Int, force:Bool = false) {
	if (change == 0 && !force) return;
	FlxG.camera.y =folderCam.y = CoolUtil.fpsLerp(folderCam.y, change * 128, 0.1);
}

function destroy() {
	window.title="vs literally every fnf fan mod ever";
	if (FlxG.save.data.crt) FlxG.camera.removeShader(cunvrehgu);
		FlxG.cameras.remove(subCam);
		FlxG.cameras.remove(folderCam);
		FlxG.cameras.remove(third);
		FlxG.camera.bgColor = 0;
		FlxG.camera.y=0;
}
