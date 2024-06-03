package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxFrame;
import flxanimate.FlxAnimate;
import openfl.Assets;

class PlayState extends FlxState
{
	var rollPath = "assets/images/albumRoll";
	var defaultFrame:FlxFrame = null;
	var roll:FlxAnimate = null;

	var num:Int = 0;

	override public function create()
	{
		super.create();
		roll = new FlxAnimate(rollPath, {Antialiasing: true});
		roll.screenCenter();
		add(roll);
		defaultFrame = roll.frames.getByIndex(0).copyTo();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (#if !mobile FlxG.keys.justPressed.SPACE #elseif android touch.justPressed #end)
		{
			if (roll.anim.isPlaying)
				roll.anim.pause();
			else
			{
				num = (num + 1) % 4;
				var graphicPath = rollPath + "/volume" + num + ".png";
				if (!Assets.exists(graphicPath))
					defaultFrame.copyTo(roll.frames.getByIndex(0));
				else
				{
					var frame = FlxG.bitmap.add(graphicPath).imageFrame.frame;
					frame.copyTo(roll.frames.getByIndex(0));
					@:privateAccess
					if (true)
					{
						var frame = roll.frames.getByIndex(0);
						frame.tileMatrix[0] = defaultFrame.frame.width / frame.frame.width;
						frame.tileMatrix[3] = defaultFrame.frame.height / frame.frame.height;
					}
				}

				roll.anim.play(true);
			}
		}
	}
}
