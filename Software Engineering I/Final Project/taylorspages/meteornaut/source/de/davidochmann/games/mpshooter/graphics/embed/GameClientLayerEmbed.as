package de.davidochmann.games.mpshooter.graphics.embed 
{
	/**
	 * @author dochmann
	 */

	import flash.display.Sprite;
	
	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="gameClientLayer")]
	
	public class GameClientLayerEmbed extends Sprite 
	{
		public var mLayerShipHitArea:LayerShipHitAreaEmbed;
		public var mLayerShip:LayerShipEmbed;
		public var mLayerMissles:LayerMisslesEmbed;
	}
}
