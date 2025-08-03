package stages;

import flixel.FlxG;
import flixel.FlxSprite;

class MallStage extends Stages {
    var upperBoppers:FlxSprite;
    var bottomBoppers:FlxSprite;
    var santa:FlxSprite;

    public function new() {
        super();
        curStage = 'mall';
    }

    override public function create() {
        super.create();
        var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls','week5'));
        bg.antialiasing = true;
        bg.scrollFactor.set(0.2, 0.2);
        bg.active = false;
        bg.setGraphicSize(Std.int(bg.width * 0.8));
        bg.updateHitbox();
        addBehind(bg);

        upperBoppers = new FlxSprite(-240, -90);
        upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop','week5');
        upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
        upperBoppers.antialiasing = true;
        upperBoppers.scrollFactor.set(0.33, 0.33);
        upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
        upperBoppers.updateHitbox();
        if(FlxG.save.data.distractions)
            addBehind(upperBoppers);

        var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator','week5'));
        bgEscalator.antialiasing = true;
        bgEscalator.scrollFactor.set(0.3, 0.3);
        bgEscalator.active = false;
        bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
        bgEscalator.updateHitbox();
        addBehind(bgEscalator);

        var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree','week5'));
        tree.antialiasing = true;
        tree.scrollFactor.set(0.40, 0.40);
        addBehind(tree);

        bottomBoppers = new FlxSprite(-300, 140);
        bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop','week5');
        bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
        bottomBoppers.antialiasing = true;
        bottomBoppers.scrollFactor.set(0.9, 0.9);
        bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
        bottomBoppers.updateHitbox();
        if(FlxG.save.data.distractions)
        	addBehind(bottomBoppers);

        var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow','week5'));
        fgSnow.active = false;
        fgSnow.antialiasing = true;
        addBehind(fgSnow);

        santa = new FlxSprite(-840, 150);
        santa.frames = Paths.getSparrowAtlas('christmas/santa','week5');
        santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
        santa.antialiasing = true;
        if(FlxG.save.data.distractions)
            add(santa);
    }

    override public function beatHit(curBeat:Int) {
        if(FlxG.save.data.distractions){
            upperBoppers.animation.play('bop', true);
            bottomBoppers.animation.play('bop', true);
            santa.animation.play('idle', true);
				}
    }
}

class MallEvil extends Stages {
    public function new() {
        super();
        curStage = 'mallEvil';
    }

    override public function create() {
        super.create();
        var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG','week5'));
        bg.antialiasing = true;
        bg.scrollFactor.set(0.2, 0.2);
        bg.active = false;
        bg.setGraphicSize(Std.int(bg.width * 0.8));
        bg.updateHitbox();
        addBehind(bg);

        var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree','week5'));
        evilTree.antialiasing = true;
        evilTree.scrollFactor.set(0.2, 0.2);
        addBehind(evilTree);

        var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow",'week5'));
        evilSnow.antialiasing = true;
        addBehind(evilSnow);
    }
}