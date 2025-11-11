function beatHit(beat){
	switch(beat){
	case 36|100:
		FlxTween.cancelTweensOf(skyBLR);
		FlxTween.cancelTweensOf(camGame);
		FlxTween.tween(camGame, {angle: 180}, 3, {ease: FlxEase.backInOut});
		FlxTween.angle(skyBLR, 0, 180, 3, {ease: FlxEase.backInOut});
		for (i in 0...4){FlxTween.tween(cpuStrums.members[i], {angle: 360}, 3, {ease: FlxEase.backInOut});}
		FlxTween.tween(camHUD, {angle: 180}, 3, {ease: FlxEase.backInOut});

		FlxTween.tween(cpuStrums.members[0], {x: 450}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[1], {x: 340}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[2], {x: 230}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[3], {x: 120}, 3, {ease: FlxEase.backInOut});
		for (i in 0...4){FlxTween.tween(playerStrums.members[i], {angle: 360}, 3, {ease: FlxEase.backInOut});}
		FlxTween.tween(playerStrums.members[0], {x: 1050}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[1], {x: 940}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[2], {x: 830}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[3], {x: 720}, 3, {ease: FlxEase.backInOut});
	case 68|164:
		FlxTween.cancelTweensOf(skyBLR);
		FlxTween.cancelTweensOf(camGame);
		FlxTween.tween(camGame, {angle: camGame.angle+180}, 3, { ease: FlxEase.backInOut} );
		FlxTween.angle(skyBLR, 0, skyBLR.angle+180, 3, { ease: FlxEase.backInOut } );

		for (i in 0...4){FlxTween.tween(cpuStrums.members[i], {angle: 0}, 3, {ease: FlxEase.backInOut});}
		FlxTween.tween(camHUD, {angle: 0}, 3, {ease: FlxEase.backInOut});

		FlxTween.tween(cpuStrums.members[0], {x: 120}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[1], {x: 230}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[2], {x: 340}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(cpuStrums.members[3], {x: 450}, 3, {ease: FlxEase.backInOut});
		for (i in 0...4){FlxTween.tween(playerStrums.members[i], {angle: 0}, 3, {ease: FlxEase.backInOut});}
		FlxTween.tween(playerStrums.members[0], {x: 720}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[1], {x: 830}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[2], {x: 940}, 3, {ease: FlxEase.backInOut});
        FlxTween.tween(playerStrums.members[3], {x: 1050}, 3, {ease: FlxEase.backInOut});
	}
}
function postCreate(){iconP1.setIcon('oldbf');
	for (i in cpuStrums.members) i.noteAngle=0;
	for (i in playerStrums.members) i.noteAngle=0;
	camGame.addShader(crt = new CustomShader('fake CRT'));
}