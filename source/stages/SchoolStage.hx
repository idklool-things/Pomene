package stages;

import flixel.FlxG;
import flixel.FlxSprite;

class SchoolStage extends Stages {
    var bgGirls:BackgroundGirls;

    public function new() {
        super();
        curStage = 'school';
    }

    override public function create() {
        super.create();
        var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky','week6'));
        bgSky.scrollFactor.set(0.1, 0.1);
        addBehind(bgSky);

        var repositionShit = -200;

        var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool','week6'));
        bgSchool.scrollFactor.set(0.6, 0.90);
        addBehind(bgSchool);

        var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet','week6'));
        bgStreet.scrollFactor.set(0.95, 0.95);
        addBehind(bgStreet);

        var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack','week6'));
        fgTrees.scrollFactor.set(0.9, 0.9);
        addBehind(fgTrees);

        var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
        var treetex = Paths.getPackerAtlas('weeb/weebTrees','week6');
        bgTrees.frames = treetex;
        bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
        bgTrees.animation.play('treeLoop');
        bgTrees.scrollFactor.set(0.85, 0.85);
        addBehind(bgTrees);

        var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
        treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals','week6');
        treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
        treeLeaves.animation.play('leaves');
        treeLeaves.scrollFactor.set(0.85, 0.85);
        addBehind(treeLeaves);

        var widShit = Std.int(bgSky.width * 6);

        bgSky.setGraphicSize(widShit);
        bgSchool.setGraphicSize(widShit);
        bgStreet.setGraphicSize(widShit);
        bgTrees.setGraphicSize(Std.int(widShit * 1.4));
        fgTrees.setGraphicSize(Std.int(widShit * 0.8));
        treeLeaves.setGraphicSize(widShit);

        fgTrees.updateHitbox();
        bgSky.updateHitbox();
        bgSchool.updateHitbox();
        bgStreet.updateHitbox();
        bgTrees.updateHitbox();
        treeLeaves.updateHitbox();

        bgGirls = new BackgroundGirls(-100, 190);
        bgGirls.scrollFactor.set(0.9, 0.9);

        if (PlayState.SONG.song.toLowerCase() == 'roses' && FlxG.save.data.distractions)
        	{
        	    bgGirls.getScared();
        	}

        bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
        bgGirls.updateHitbox();
        if(FlxG.save.data.distractions)
            addBehind(bgGirls);
    }

    override public function beatHit(curBeat:Int) {
        if(FlxG.save.data.distractions)
            bgGirls.dance();
    }
}

class SchoolEvil extends Stages {
    public function new() {
        super();
        curStage = 'schoolEvil';
    }

    override public function create() {
        super.create();
        var posX = 400;
        var posY = 200;

        var bg:FlxSprite = new FlxSprite(posX, posY);
        bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool','week6');
        bg.animation.addByPrefix('idle', 'background 2', 24);
        bg.animation.play('idle');
        bg.scrollFactor.set(0.8, 0.9);
        bg.scale.set(6, 6);
        addBehind(bg);
    }
}