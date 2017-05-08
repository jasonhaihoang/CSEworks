package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="statsEntry")]
	
	public class StatsEntry extends Sprite 
	{
		public var mStar0:Sprite;
		public var mStar1:Sprite;
		public var mStar2:Sprite;
		public var mLevel:TextField;
		public var mTime:TextField;
		public var mCombo:TextField;
		public var mScore:TextField;
	}
}
