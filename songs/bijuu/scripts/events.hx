function stepHit(step){
	switch(curStep) 
	{
		case 248:defaultCamZoom += 0.2;
		case 256:defaultCamZoom -= 0.1;
			FlxG.camera.flash(FlxColor.WHITE, 1);
		case 416|480:defaultCamZoom += 0.1;
		case 448|896:defaultCamZoom -= 0.1;
		case 512:FlxG.camera.flash(FlxColor.WHITE, 1);
			defaultCamZoom -= 0.2;
		case 888:defaultCamZoom += 0.3;
		case 1152|1168:defaultCamZoom += 0.05;
		case 1184:defaultCamZoom -= 0.3;
	}
}