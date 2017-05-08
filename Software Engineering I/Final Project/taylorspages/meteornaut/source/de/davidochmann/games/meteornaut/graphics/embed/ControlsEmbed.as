package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="controls")]
	 
	public class ControlsEmbed extends Sprite 
	{
		public var mButtonBack:MovieClip;
	}
}
