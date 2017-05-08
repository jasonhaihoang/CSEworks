package de.davidochmann.games.mpshooter.graphics.embed 
{
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="userInterface")]
	
	public class UserInterfaceEmbed extends Sprite 
	{
		public var mIntro:UserInterfaceIntroEmbed;
	}
}
