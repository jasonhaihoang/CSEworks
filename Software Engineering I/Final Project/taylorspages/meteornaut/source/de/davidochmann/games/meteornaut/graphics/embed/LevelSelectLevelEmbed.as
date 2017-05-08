package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="levelSelectLevel")]
	 
	public class LevelSelectLevelEmbed extends MovieClip
	{
		public var mLock:Sprite;
		public var mName:TextField;
		public var mStar0:Sprite;
		public var mStar1:Sprite;
		public var mStar2:Sprite;
	}
}
