package;

import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	var char:String = '';
	var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);
		if (char.endsWith('-pixel') || char.toLowerCase() == Std.string(['senpai', 'spirit']))
		  antialiasing = false;
		else
		  antialiasing = true;
		scrollFactor.set();
	}

	public var isOldIcon:Bool = false;

	public function swapOldIcon():Void
	{
		isOldIcon = !isOldIcon;

		if (isOldIcon)
			changeIcon('bf-old');
		else
			changeIcon(PlayState.boyfriend.chars.icon);
	}

	public function changeIcon(newChar:String):Void
	{
		/*if (newChar != 'bf-pixel' && newChar != 'bf-old')
			newChar = newChar.split('-')[0].trim();*/

		if (newChar != char)
		{
			if (animation.getByName(newChar) == null)
			{
			  if (Paths.image('icons/icon-' + newChar) != null) {
				loadGraphic(Paths.image('icons/icon-' + newChar), true, 150, 150);
				animation.add(newChar, [0, 1], 0, false, isPlayer);
				animation.play(newChar);
			  } else {
			    loadGraphic(Paths.image('icons/icon-face'), true, 150, 150);
			    animation.add('face', [0, 1], 0, false, isPlayer);
			    animation.play('face');
			  }
			}
			char = newChar;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
