package de.davidochmann.games.racer.graphics.embed 
{
	/**
	 * @author dochmann
	 */

	import flash.display.Sprite;
	
	[Embed (source="../../../../../../../library/racer/embed.swf", symbol="car")]
	 
	public class Car extends Sprite 
	{
		public var mDirX:Number;
		public var mDirY:Number;
		public var mSpeed:Number;
	}
}
