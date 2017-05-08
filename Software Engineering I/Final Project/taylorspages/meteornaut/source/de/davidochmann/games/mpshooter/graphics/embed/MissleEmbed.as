package de.davidochmann.games.mpshooter.graphics.embed 
{
	/**
	 * @author David Ochmann
	 */

	import flash.display.Sprite;

	[Embed (source="../../../../../../../library/mpshooter/embed.swf", symbol="missle")]

	public class MissleEmbed extends Sprite 
	{
		public var mDirX:Number;
		public var mDirY:Number;
		
		public function MissleEmbed(){}
	}
}
