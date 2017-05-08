package de.davidochmann.games.mpshooter.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */

	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="userInterfaceIntro")]

	public class UserInterfaceIntroEmbed extends Sprite 
	{
		public var mCopyButton:UserInterfaceIntroCopyButtonEmbed;
		public var mTextMask:Sprite;
		public var mText:TextField;
	}
}
