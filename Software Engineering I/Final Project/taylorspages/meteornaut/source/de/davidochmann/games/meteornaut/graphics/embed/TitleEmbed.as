package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="title")]
	 
	public class TitleEmbed extends Sprite 
	{
		public var mStar0:Sprite;
		public var mStar1:Sprite;
		public var mStar2:Sprite;
		public var mButtonPlay:MovieClip;
		public var mButtonStats:MovieClip;
		public var mButtonSettings:MovieClip;
		public var mButtonControls:MovieClip;
		public var mButtonAbout:MovieClip;
	}
}
