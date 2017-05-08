package de.davidochmann.games.meteornaut.graphics.embed
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	
	[Embed (source="../../../../../../../library/meteornaut/embed.swf", symbol="game")]
	
	public class GameEmbed extends Sprite 
	{
		public var mPauseIcon:MovieClip;
		public var mClientLayer:GameClientLayerEmbed;
		public var mBackground:Sprite;	
	}
}
