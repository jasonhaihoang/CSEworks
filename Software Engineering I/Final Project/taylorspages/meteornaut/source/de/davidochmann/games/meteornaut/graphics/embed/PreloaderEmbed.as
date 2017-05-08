package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="preloader")]
	
	public class PreloaderEmbed extends Sprite 
	{
		public var mBar:Sprite;
		public var mLabel:TextField;
	}
}
