package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="gameOver")]
	
	public class GameOverEmbed extends Sprite 
	{
		public var mFloppy:MovieClip;
		public var mTitle:TextField;
		public var mLevel:TextField;
//		public var mTipContainer:MovieClip;
		public var mMenuButton:MovieClip;
		public var mLockButton:MovieClip;
		public var mNextButton:MovieClip;
		public var mRepeatButton:MovieClip;
		public var mScore:TextField;
		public var mMaxCombo:TextField;
		public var mTime:TextField;
		public var mStar0:Sprite;
		public var mStar1:Sprite;
		public var mStar2:Sprite;
	}
}
