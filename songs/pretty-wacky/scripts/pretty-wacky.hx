import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;
var snowemitter:FlxTypedEmitter = new FlxTypedEmitter(FlxG.camera.scroll.x,0,300);
var time = 0;
var mosaic = new CustomShader("mosaic");
var chrom = new CustomShader("chromatic aberration");
var baro:FlxSprite = new FlxSprite().makeSolid(150, FlxG.height*3, FlxColor.BLACK);
var bart:FlxSprite = new FlxSprite().makeSolid(150, FlxG.height*3, FlxColor.BLACK);
function postCreate(){
	for(i in [healthBarBG1,healthBarBG2,missesTxt,accuracyTxt,scoreTxt,iconP1,iconP2,scoreTxt,comboGroup,bart,baro])
	i.alpha=0.001;
	camHUD.color = FlxColor.GRAY;
	bart.x = FlxG.width-150;
	for(i in [bart,baro]){
  	insert(2,i).camera = camHUD;
  	i.scrollFactor.set();
	}
	defaultStrumX = [[cpuStrums.members[0].x,cpuStrums.members[1].x,cpuStrums.members[2].x,cpuStrums.members[3].x],[playerStrums.members[0].x,playerStrums.members[1].x,playerStrums.members[2].x,playerStrums.members[3].x]];
	trace(defaultStrumX);
}
function update(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);}
function stepHit(curStep){
	switch(curStep){
		case 250: defaultCamZoom += 0.2;
		case 256: snowemitter.width = FlxG.width*1.5;
		snowemitter.velocity.set(-10, -240, 10, -320);
		snowemitter.lifespan.set(5);
		snowemitter.acceleration.set(0, -100);

		for (i in 0...150) {
			var p = new FlxParticle().makeGraphic(12,12,FlxColor.GRAY);
			var p2 = new FlxParticle().makeGraphic(24,24,FlxColor.GRAY);

			snowemitter.add(p);
			snowemitter.add(p2);
		}
        insert(6, snowemitter);
		snowemitter.start(false, 0.05);

        snowemitter.x = FlxG.camera.scroll.x -300;
        snowemitter.y = FlxG.camera.scroll.y+FlxG.height+40;
		for(i in [healthBarBG1,healthBarBG2,missesTxt,accuracyTxt,scoreTxt,iconP1,iconP2,scoreTxt,comboGroup])
			i.alpha=1;
		defaultCamZoom -= 0.1;
		stage.getSprite("graadienter").color = stage.getSprite("wbg").color = FlxColor.WHITE;
		case 752: defaultCamZoom += 0.1;
		case 761:  if (FlxG.save.data.mosaic){mosaic.uBlocksize = 1;
			FlxG.camera.addShader(mosaic);
		}
		case 762: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 2;
		case 763: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 3;
		case 764: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 6;
		case 765: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 9;
		case 766: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 13;
		case 767: if(FlxG.save.data.mosaic)mosaic.uBlocksize = 20;
		case 768: if(FlxG.save.data.mosaic)FlxG.camera.removeShader(mosaic);
		baro.alpha = bart.alpha = cameraSpeed = 3;
		if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
		FlxG.camera.zoom -= defaultCamZoom -= 0.1;
		case 1280: baro.alpha = bart.visible = false;
		if (FlxG.save.data.chrom) FlxG.camera.removeShader(chrom);
		cameraSpeed = 1;
		FlxG.camera.zoom += defaultCamZoom += 0.1;
		case 1808: FlxTween.tween(camHUD, {alpha: 0}, 2, {ease: FlxEase.circInOut});
	}	
	if (curStep >= 256){
		if ((curStep <= 512) && (curStep % 4 == 0)){
			if (curStep % 8 == 0){
				camGame.angle -= 2;	camHUD.angle -= 4;
			}else{
				camGame.angle = 2;	camHUD.angle = 4;
			}
			FlxTween.tween(camGame, {angle: 0}, 0.4, {ease: FlxEase.circOut});
			FlxTween.tween(camHUD, {angle: 0}, 0.4, {ease: FlxEase.circOut});
		}
	}
}

var defaultStrumX:Array<Float> = [[96,208,320,432],[736,848,960,1072]];
var strumCenter:Array<Float> = [[160,272,384,496],[672,784,896,1008]];
var fuck:Bool=false;
public function strumcenter(){
	fuck=!fuck;
	for (i in 0...4) { 
		FlxTween.tween(cpuStrums.members[i], {x: strumCenter[0][i]}, 0.2, {ease: FlxEase.circOut});
		FlxTween.tween(playerStrums.members[i], {x: strumCenter[1][i]}, 0.2, {ease: FlxEase.circOut});
		if(!fuck){
			FlxTween.tween(cpuStrums.members[i], {x: defaultStrumX[0][i]}, 0.2, {ease: FlxEase.circOut});
			FlxTween.tween(playerStrums.members[i], {x: defaultStrumX[1][i]}, 0.2, {ease: FlxEase.circOut});
		}
	}
}