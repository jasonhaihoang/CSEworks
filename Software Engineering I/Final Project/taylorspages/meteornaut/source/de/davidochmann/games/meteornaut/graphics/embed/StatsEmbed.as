package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */

	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="stats")]

	public class StatsEmbed extends Sprite 
	{
		public var mButtonBack:MovieClip;
		public var mScrollerButton:MovieClip;
		public var mScrollerLine:Sprite;
		public var mMask:Sprite;
		public var mContent:Sprite;
	}
}
