package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */

	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="settings")]

	public class SettingsEmbed extends Sprite 
	{
		public var mButtonBack:MovieClip;
		public var mScrollerButton:ScrollerButtonVolumeEmbed;
		public var mScrollerLine:Sprite;
	}
}
