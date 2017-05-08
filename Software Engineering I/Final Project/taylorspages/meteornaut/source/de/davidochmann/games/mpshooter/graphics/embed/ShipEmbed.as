package de.davidochmann.games.mpshooter.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author David Ochmann
	 */

	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="ship")]

	public class ShipEmbed extends Sprite 
	{
		public var mInterface:ShipInterfaceEmbed;
		public var mBorder:Sprite;
		public var mBody:Sprite;
		public var mAniHit:MovieClip;
	}
}
