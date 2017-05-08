package de.davidochmann.games.mpshooter.graphics.embed 
{
	/**
	 * @author dochmann
	 */
	
	import flash.display.Sprite;

	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="layerShip")]

	public class LayerShipEmbed extends Sprite 
	{
		public var mShip:ShipEmbed;
	}
}
