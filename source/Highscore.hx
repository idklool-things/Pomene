package;

import flixel.FlxG;

class Highscore
{
	#if (haxe >= "4.0.0")
	public static var songScores:Map<String, Int> = new Map();
	#else
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	#end

	public static function saveScore(song:String, score:Int = 0, ?diff:String = 'easy'):Void
	{
		var formattedSong:String = formatSong(song, diff);

		#if newgrounds
		NGio.postScore(score, song);
		#end

		if (songScores.exists(formattedSong))
		{
			if (songScores.get(formattedSong) < score)
				setScore(formattedSong, score);
		}
		else
			setScore(formattedSong, score);
	}

	public static function saveWeekScore(week:String = '', score:Int = 0, ?diff:String = 'easy'):Void
	{
		#if newgrounds
		NGio.postScore(score, "Week " + week);
		#end

		var formattedSong:String = formatSong(week, diff);

		if (songScores.exists(formattedSong))
		{
			if (songScores.get(formattedSong) < score)
				setScore(formattedSong, score);
		}
		else
			setScore(formattedSong, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(formattedSong:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(formattedSong, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:String):String
	{
		var daSong:String = song.toLowerCase();

		if (diff.toLowerCase() != 'normal')
			daSong += '-' + diff.toLowerCase();
		
		return daSong;
	}

	public static function getScore(song:String, diff:String):Int
	{
		if (!songScores.exists(formatSong(song, diff)))
			setScore(formatSong(song, diff), 0);

		return songScores.get(formatSong(song, diff));
	}

	public static function getWeekScore(week:String, ?diff:String):Int
	{
		if (!songScores.exists(formatSong(week, diff)))
			setScore(formatSong(week, diff), 0);

		return songScores.get(formatSong(week, diff));
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
			songScores = FlxG.save.data.songScores;
	}
}
