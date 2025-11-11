import flixel.math.FlxPoint;

import funkin.editors.ui.UIButton;

import funkin.editors.ui.UIButtonList;
import funkin.editors.ui.UIText;

class FUCK extends UIState {
	public override function create() {
			super.create();
			

			tb = new UITextBox(435, 220, '', 410, 44, false);
    tb.multiline = false;
	tb.label.setFormat(Paths.font('vcr.ttf'), 30, FlxColor.BLACK);

	tb.caretSpr.color = FlxColor.BLACK;
	tb.caretSpr.scale.set(1, 30);
	tb.caretSpr.offset.set(0, -14);
    add(tb);
	}
}