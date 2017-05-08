package de.davidochmann.games.mpshooter.graphics.embed 
{
	import flash.display.Sprite;
	
	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="game")]
	
	public class GameEmbed extends Sprite 
	{
		public var mClientMaster:GameClientLayerEmbed;
		public var mClientSlave:GameClientLayerEmbed;
		public var mBackground:Sprite;
	}
}
