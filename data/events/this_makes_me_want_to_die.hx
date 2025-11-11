case "Bitto's zoom event":
	if (value1 != "regular" && value1 != "custom" && value1 != "") {
		// bloodshed legacy redux zooms. they r fucked up for some reason
		value2 = value1.split(",")[1] + "," + value1.split(",")[2] + "," + value2;
		value1 = "custom";
	}
	defaultCamZoom = Std.parseFloat(value2);
	FlxTween.tween(camGame, {zoom: Std.parseFloat(value2.split(',')[0])}, Std.parseFloat(value2.split(',')[1]), {ease:
	switch(value2.split(',')[2]) {
					case 'backin': FlxEase.backIn;
					case 'backinout': FlxEase.backInOut;
					case 'backout': FlxEase.backOut;
					case 'bouncein': FlxEase.bounceIn;
					case 'bounceinout': FlxEase.bounceInOut;
					case 'bounceout': FlxEase.bounceOut;
					case 'circin': FlxEase.circIn;
					case 'circinout': FlxEase.circInOut;
					case 'circout': FlxEase.circOut;
					case 'cubein': FlxEase.cubeIn;
					case 'cubeinout': FlxEase.cubeInOut;
					case 'cubeout': FlxEase.cubeOut;
					case 'elasticin': FlxEase.elasticIn;
					case 'elasticinout': FlxEase.elasticInOut;
					case 'elasticout': FlxEase.elasticOut;
					case 'expoin': FlxEase.expoIn;
					case 'expoinout': FlxEase.expoInOut;
					case 'expoout': FlxEase.expoOut;
					case 'quadin': FlxEase.quadIn;
					case 'quadinout': FlxEase.quadInOut;
					case 'quadout': FlxEase.quadOut;
					case 'quartin': FlxEase.quartIn;
					case 'quartinout': FlxEase.quartInOut;
					case 'quartout': FlxEase.quartOut;
					case 'quintin': FlxEase.quintIn;
					case 'quintinout': FlxEase.quintInOut;
					case 'quintout': FlxEase.quintOut;
					case 'sinein': FlxEase.sineIn;
					case 'sineinout': FlxEase.sineInOut;
					case 'sineout': FlxEase.sineOut;
					case 'smoothstepin': FlxEase.smoothStepIn;
					case 'smoothstepinout': FlxEase.smoothStepInOut;
					case 'smoothstepout': FlxEase.smoothStepInOut;
					case 'smootherstepin': FlxEase.smootherStepIn;
					case 'smootherstepinout': FlxEase.smootherStepInOut;
					case 'smootherstepout': FlxEase.smootherStepOut;
					case _: FlxEase.linear;
				}});










Bijuu:
[
	25000,
	[
		[
			"Bitto's zoom event",
			"custom",
			"1.2,0.01,expoOut"
		]
	]
],

BLR:
[
	79436.6197183099,
	[
		[
			"Bitto's zoom event",
			"camGame,1,1.69",
			"expoOut"
		]
	]
],