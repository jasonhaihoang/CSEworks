package de.davidochmann.games.mpshooter.graphics.embed 
{
//	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author dochmann
	 */

	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="shipInterface")]

	public class ShipInterfaceEmbed extends Sprite 
	{
		public var mKills:TextField;
//		public var mAniHit:MovieClip;
		public var mEnergy07:Sprite;
		public var mEnergy06:Sprite;
		public var mEnergy05:Sprite;
		public var mEnergy04:Sprite;
		public var mEnergy03:Sprite;
		public var mEnergy02:Sprite;
		public var mEnergy01:Sprite;
		public var mEnergy00:Sprite;
	}
}
