package de.davidochmann.games.mpshooter.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="userInterfaceIntroTextContainer")]
	
	public class UserInterfaceIntroTextContainerEmbed extends Sprite 
	{
		public var mText:TextField;
	}
}
