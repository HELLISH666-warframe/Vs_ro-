import flixel.FlxSprite;
import flixel.FlxState;
import CustomFadeTransition;

var loadingA:String = Std.string(FlxG.random.int(1, 9));

public static var CURRENT_LOADING_SCREEN = loadingA;

var loadingScreen:FlxSprite;

static var loadingPlayState = false;

var out = newState != null;

function onOpenSubState(e){
e.cancel();
}

function create() {

	remove(transitionSprite);
	remove(blackSpr);

	if (!out){
	openSubState(new CustomFadeTransition(0.68, true));
	}
	else{
	openSubState(new CustomFadeTransition(0.68, false));
	}
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