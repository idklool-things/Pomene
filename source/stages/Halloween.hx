package stages;

import flixel.FlxG;
import flixel.FlxSprite;

class Halloween extends Stages {
    var halloweenBG:FlxSprite;

    public function new() {
        super();
        curStage = 'halloween';
    }

    override public function create() {
        super.create();
        halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = Paths.getSparrowAtlas('halloween_bg','week2');

				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				addBehind(halloweenBG);
    }

    function lightningStrikeShit(curBeat:Int):Void
    {
        FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
        halloweenBG.animation.play('lightning');

        lightningStrikeBeat = curBeat;
        lightningOffset = FlxG.random.int(8, 24);

        boyfriend.playAnim('scared', true);
        gf.playAnim('scared', true);
    }

    var lightningStrikeBeat:Int = 0;
    var lightningOffset:Int = 8;

    override public function beatHit(curBeat:Int) {
        super.beatHit(curBeat);
        if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
        {
            if(FlxG.save.data.distractions)
                lightningStrikeShit(curBeat);
        }
    }
}