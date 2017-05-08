package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="scrollerButtonVolume")]
	 
	public class ScrollerButtonVolumeEmbed extends Sprite 
	{
		public var mLabel:TextField;
	}
}
