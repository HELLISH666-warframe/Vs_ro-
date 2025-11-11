function onEvent(_) {
	if (_.event.name == 'move_char') {
		var uidfgvidfbjhidf:Int= _.event.params[2];
		var kys:Int= _.event.params[3];
		var cock = strumLines.members[_.event.params[0]].characters[0];
		trace(cock.x,cock.y);
		FlxTween.tween(cock, 
			{x:cock.x+ uidfgvidfbjhidf, y:cock.y+kys},
			 _.event.params[1], {ease: CoolUtil.flxeaseFromString(_.event.params[4])});
			 trace(cock.x,cock.y);
	}
}