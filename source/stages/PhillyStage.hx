package stages;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;

class PhillyStage extends Stages
{
    var phillyCityLights:FlxTypedGroup<FlxSprite>;
    var phillyTrain:FlxSprite;
    var trainSound:FlxSound;

    public function new()
    {
        super();
        curStage = 'philly';
    }

    override public function create()
    {
        super.create();
        var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky', 'week3'));
        bg.scrollFactor.set(0.1, 0.1);
        addBehind(bg);

        var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city', 'week3'));
        city.scrollFactor.set(0.3, 0.3);
        city.setGraphicSize(Std.int(city.width * 0.85));
        city.updateHitbox();
        addBehind(city);

        phillyCityLights = new FlxTypedGroup<FlxSprite>();
        if (FlxG.save.data.distractions)
            addBehind(phillyCityLights);

        for (i in 0...5)
        {
            var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i, 'week3'));
            light.scrollFactor.set(0.3, 0.3);
            light.visible = false;
            light.setGraphicSize(Std.int(light.width * 0.85));
            light.updateHitbox();
            light.antialiasing = true;
            phillyCityLights.add(light);
        }

        var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain', 'week3'));
        addBehind(streetBehind);

        phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train', 'week3'));
        if (FlxG.save.data.distractions)
            addBehind(phillyTrain);

        trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes', 'week3'));
        FlxG.sound.list.add(trainSound);

        var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street', 'week3'));
        addBehind(street);
    }

    override public function update(elapsed:Float)
    {
        if (trainMoving)
				{
				    trainFrameTiming += elapsed;

				    if (trainFrameTiming >= 1 / 24)
				    {
				        updateTrainPos();
				        trainFrameTiming = 0;
				    }
				}
        super.update(elapsed);
    }

    var trainMoving:Bool = false;
    var trainFrameTiming:Float = 0;

    var trainCars:Int = 8;
    var trainFinishing:Bool = false;
    var trainCooldown:Int = 0;

    function trainStart():Void
    {
        if(FlxG.save.data.distractions){
            trainMoving = true;
            if (!trainSound.playing)
                trainSound.play(true);
        }
    }

    var startedMoving:Bool = false;

    function updateTrainPos():Void
    {
        if(FlxG.save.data.distractions){
            if (trainSound.time >= 4700)
            {
                startedMoving = true;
                if (gf != null)
                    gf.playAnim('hairBlow');
            }

            if (startedMoving)
            {
                phillyTrain.x -= 400;

                if (phillyTrain.x < -2000 && !trainFinishing)
                {
                    phillyTrain.x = -1150;
                    trainCars -= 1;

                    if (trainCars <= 0)
                        trainFinishing = true;
                }

                if (phillyTrain.x < -4000 && trainFinishing)
                    trainReset();
            }
        }
    }

    function trainReset():Void
    {
        if(FlxG.save.data.distractions){
          if (gf != null)
              gf.playAnim('hairFall');
          phillyTrain.x = FlxG.width + 200;
          trainMoving = false;
          trainCars = 8;
          trainFinishing = false;
          startedMoving = false;
        }
    }

    var curLight:Int = 0;
    override public function beatHit(curBeat:Int)
    {
        super.beatHit(curBeat);
        if(FlxG.save.data.distractions){
            if (!trainMoving)
                trainCooldown += 1;
	
            if (curBeat % 4 == 0)
            {
                phillyCityLights.forEach(function(light:FlxSprite)
                light.visible = false);

                curLight = FlxG.random.int(0, phillyCityLights.length - 1);

                phillyCityLights.members[curLight].visible = true;
            }
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
				    if(FlxG.save.data.distractions){
				      trainCooldown = FlxG.random.int(-4, 0);
				      trainStart();
				    }
				}
    }
}