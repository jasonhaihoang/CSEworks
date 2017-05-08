package de.davidochmann.games.meteornaut.graphics.embed 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	 
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="ship")]
	
	public class ShipEmbed extends Sprite 
	{
		public var mAnimationExplosion:MovieClip;
		public var mBody:Sprite;
		public var mInterface:ShipInterfaceEmbed;
	}
}
