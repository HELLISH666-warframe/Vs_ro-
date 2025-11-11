
import funkin.editors.ui.UIText;
import funkin.menus.ModSwitchMenu;
import funkin.editors.ui.UITextBox;
import funkin.editors.ui.UIState;
//import flixel.text.FlxTextFormat;
import flixel.addons.display.FlxBackdrop;
import hxvlc.flixel.FlxVideoSprite;

var heads, shit, video;
var tb:UITextBox;
var canSelect = true;
var marvin = false;

var list = [
    'shuck' => ['song', 'shucks'],
    'roses' => ['song', 'execretion'],
    'sleep' => ['song', 'the corpse is mocking me'],
    'grief' => ['song', 'revenant'],
    'bloom' => ['song', 'cordyceps'],

    'poop' => ['image'],
    'bart' => ['image'],
    'mew' => ['image'],
    'ratio' => ['image'],
    'chill' => ['image'],
    'boing' => ['image'],
    'dirty' => ['image'],
    'happy' => ['image'],
    'bufftg' => ['image'],
    'smile' => ['image'],
    'iridadog' => ['image'],
    'dctg' => ['image'],

    'aetho' => ['video', 470, 50, 1.62, 0.8],
    'penis' => ['video', -90, -300, 0.36, 0.3],
    'plane' => ['video', 210, 50, 0.65, 0.8],
    'sling' => ['video', 212, 50, 0.65, 0.8],
    'final' => ['video', -10, -100, 0.42, 0.5],
    'sucks' => ['video', 220, -10, 0.6, 0.65],

    'marvin mode' => ['marvinMode']
];

function postCreate() {
    FlxG.mouse.visible = true;
    
    tb = new UITextBox(435, 220, '', 410, 44, false);
    tb.multiline = false;
	tb.label.setFormat(Paths.font('vcr.ttf'), 30, FlxColor.BLACK);

	tb.caretSpr.color = FlxColor.BLACK;
	tb.caretSpr.scale.set(1, 30);
	tb.caretSpr.offset.set(0, -14);
    add(tb);

    add(shit = new FlxSprite(140, -120)).scale.set(0.55, 0.45);
    add(video = new FlxVideoSprite()).alpha = shit.alpha = 0;

    FlxTween.tween(window, {opacity: 1}, 1, {ease: FlxEase.expoOut});
}

function update() {

    if (FlxG.keys.justPressed.ESCAPE) {
        FlxTween.tween(window, {opacity: 0}, 0.5, {ease: FlxEase.expoOut});
        FlxG.sound.music.fadeOut(0.5, 0);
        
        new FlxTimer().start(1, () -> {FlxG.switchState(new ModState('custom/mainmenu'));});
    }

    if (controls.SEVEN) tb.label.text == '';

    if (controls.ACCEPT && canSelect) {
        var t = list[tb.label.text];

        if (t != null) {
            switch(t[0]) {
                case 'song':
                    PlayState.loadSong(t[1], 'hard');
                    FlxG.switchState(new PlayState());

                case 'image':
                    canSelect = tb.selectable = false;
                    shit.alpha = 1;
                    shit.loadGraphic(Paths.image('menus/code/shitpost/' + tb.label.text));
                    new FlxTimer().start(1, function(t:FlxTimer) {
                        FlxTween.tween(shit, {alpha: 0}, 2.5, {ease: FlxEase.circOut, onComplete: function(t:FlxTween) {canSelect = tb.selectable = true;}});
                    });

                case 'video':
                    canSelect = tb.selectable = false;
                    video.alpha = 1;
                    video.setPosition(t[1], t[2]);
                    video.load(Assets.getPath(Paths.video('codes/' + tb.label.text)));
                    video.scale.set(t[3], t[4]);
                    video.play();

                    video.bitmap.onEndReached.add(vidEnd);
                    FlxG.sound.music.fadeOut(0.5, 0);
                
                case 'marvinMode':
                    marvin = !marvin;

                    if (marvin) {
                        insert(1, heads = new FlxBackdrop(Paths.image('menus/code/shitpost/heads'))).scrollFactor.set(0.5, 0.5);
                        heads.screenCenter();
                        heads.velocity.x = -45; 
                    }
                    else remove(heads, true);
            }
        }
    }
}