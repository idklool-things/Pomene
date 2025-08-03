var pomni:FlxSprite;
function create()
{
    pomni = new FlxSprite(-590, 250);
    pomni.frames = Paths.getSparrowAtlas('pomni');
    pomni.animation.addByPrefix('looppomni', 'pomni', 24, true);
    pomni.cameras = [camHUD2];
    add(pomni);
}
function stepHit()
{
    if (curStep == 48)
    {
        FlxTween.tween(pomni, {x: -90}, 2, {ease: FlxEase.circOut});
    }
    else if (curStep == 73)
    {
        FlxTween.tween(pomni, {x: -590}, 0.7, {ease: FlxEase.circOut, onComplete: _ -> pomni.destroy()});
    }
}