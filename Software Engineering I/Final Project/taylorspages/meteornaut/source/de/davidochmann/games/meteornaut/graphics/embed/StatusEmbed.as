package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="status")] 
	
	public class StatusEmbed extends MovieClip 
	{
		public var mText:StatusTextEmbed;
	}
}
