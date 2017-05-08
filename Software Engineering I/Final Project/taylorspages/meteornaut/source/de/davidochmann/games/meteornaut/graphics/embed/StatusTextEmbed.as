package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * @author dochmann
	 */

	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="statusText")] 

	public class StatusTextEmbed extends Sprite 
	{
		public var mTextField:TextField;
	}
}
