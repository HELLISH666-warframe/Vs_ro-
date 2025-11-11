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

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	public var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	public var isTransIn:Bool = false;
	public var woah:FlxState;

	public function new(duration:Float, isTransIn:Bool,state:FlxState) {
		super();

		this.isTransIn = isTransIn;
		woah=state;
		var zoom:Float = FlxMath.bound(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);
		finishCallback="wow";

		var transData = new TransitionData(cast 'tiles', 0xFF000000, duration, new FlxPoint(0,1));
		transData.tileData = {width: 32, height: 32, asset: FlxGraphic.fromBitmapData(new GraphicTransTileCircle(0, 0, true, 0xFF000000))};
		var transitional = new Transition(transData);
		FlxG.state.add(transitional);
		new FlxTimer().start(duration, function(tmr:FlxTimer) {if(!isTransIn && finishCallback != null)finishh(); else finishh();});
		transitional.setStatus(isTransIn?TransitionStatus.FULL:TransitionStatus.EMPTY);
		transitional.start(isTransIn?TransitionStatus.OUT:TransitionStatus.IN);

		if(nextCamera != null) {
			transitional.cameras = [nextCamera];
		}
	}
	var KYS:Bool=false;
	public function finishh(){
		if(KYS) return;
	    if (woah != null) FlxG.switchState(woah);
		KYS=true;
    }

	public override function destroy() {
		if(leTween != null) {
			trace("Fuck");
			leTween.cancel();
		}
		super.destroy();
	}
}