package stages;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;

class LimoStage extends Stages {
    static var limo:FlxSprite;
    var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
    var fastCar:FlxSprite;

    public function new() {
        super();
        curStage = 'limo';
    }

    override public function create() {
        super.create();
        var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset','week4'));
        skyBG.scrollFactor.set(0.1, 0.1);
        addBehind(skyBG);

        var bgLimo:FlxSprite = new FlxSprite(-200, 480);
        bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo','week4');
        bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
        bgLimo.animation.play('drive');
        bgLimo.scrollFactor.set(0.4, 0.4);
        addBehind(bgLimo);
        if(FlxG.save.data.distractions){
            grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
            addBehind(grpLimoDancers);

            for (i in 0...5)
            {
                var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
                dancer.scrollFactor.set(0.4, 0.4);
                grpLimoDancers.add(dancer);
            }
        }

        var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay','week4'));
        overlayShit.alpha = 0.5;

        limo = new FlxSprite(-120, 550);
        limo.frames = Paths.getSparrowAtlas('limo/limoDrive','week4');
        limo.animation.addByPrefix('drive', "Limo stage", 24);
        limo.animation.play('drive');
        limo.antialiasing = true;
        // *Clap, Clap, Clap, Clap*
        addBehind(limo, 'dad');

        fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol','week4'));
        if(FlxG.save.data.distractions){
            resetFastCar();
            addBehind(fastCar);
        }
    }

    var fastCarCanDrive:Bool = true;

    function resetFastCar():Void
    {
        if(FlxG.save.data.distractions){
            fastCar.x = -12600;
            fastCar.y = FlxG.random.int(140, 250);
            fastCar.velocity.x = 0;
            fastCarCanDrive = true;
        }
    }

    function fastCarDrive()
    {
        if(FlxG.save.data.distractions){
            FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

        fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
        fastCarCanDrive = false;
        new FlxTimer().start(2, function(tmr:FlxTimer)
            resetFastCar());
        }
    }

    override public function beatHit(curBeat:Int)
    {
        super.beatHit(curBeat);
        if(FlxG.save.data.distractions){
					grpLimoDancers.forEach(function(dancer:BackgroundDancer)
							dancer.dance());
		
						if (FlxG.random.bool(10) && fastCarCanDrive)
							fastCarDrive();
				}
    }
}