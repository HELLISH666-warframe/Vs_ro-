import flixel.FlxSprite;
import flixel.FlxState;
import CustomFadeTransition;
import flixel.math.FlxPoint;
import flixel.addons.transition.Transition;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileCircle;
import flixel.addons.transition.FlxTransitionSprite.TransitionStatus;
import flixel.addons.transition.TransitionData;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.graphics.FlxGraphic;
import funkin.backend.MusicBeatSubstate;

var loadingA:String = Std.string(FlxG.random.int(1, 9));

public static var CURRENT_LOADING_SCREEN = loadingA;

var loadingScreen:FlxSprite;

static var loadingPlayState = false;

var out = newState != null;

public static var finishCallback:Void->Void;
	public var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	public var isTransIn:Bool = false;
	public var woah:FlxState;
	public var duration;

function onOpenSubState(e){
e.cancel();
}

function create() {
	remove(transitionSprite);
	remove(blackSpr);
	out ? duration=0.68 : duration=0.68;

var zoom:Float = FlxMath.bound(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);

		var transData = new TransitionData(cast 'tiles', 0xFF000000, duration, new FlxPoint(0,1));
		transData.tileData = {width: 32, height: 32, asset: FlxGraphic.fromBitmapData(new GraphicTransTileCircle(0, 0, true, 0xFF000000))};
		var transitional = new Transition(transData);
		FlxG.state.add(transitional);
		new FlxTimer().start(duration, function(tmr:FlxTimer) {if(!transOut && finishCallback != null)finishh(); else close();});
		transitional.setStatus(transOut?TransitionStatus.EMPTY:TransitionStatus.FULL);
		transitional.start(transOut?TransitionStatus.IN:TransitionStatus.OUT);
}

//stolen_from_voiid_:(
function postCreate(){
	if (newState is PlayState){
		loadingScreen = new FlxSprite().loadGraphic(Paths.image("menus/loading-screens/"+CURRENT_LOADING_SCREEN));

		loadingScreen.antialiasing = true;
		loadingScreen.scrollFactor.set(0,0);
		if (out) {
			transitionTween.onComplete = function(twn) {
				add(loadingScreen);

				loadingScreen.alpha = 0;
				
				FlxTween.tween(loadingScreen, {alpha: 1}, 0.6, {ease:FlxEase.sineOut, onComplete:function(twn)
				{
					nextFrameSkip = true;
				}});
				FlxG.sound.music.fadeOut(0.6, 0);
			}
		}
	}
}	