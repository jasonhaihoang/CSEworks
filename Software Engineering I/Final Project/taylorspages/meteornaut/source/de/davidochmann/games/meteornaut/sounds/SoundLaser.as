package de.davidochmann.games.meteornaut.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../library/meteornaut/embed.swf", symbol="soundLaser")]
	 
	public class SoundLaser extends Sound 
	{
		public function SoundLaser(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super(stream, context);
		}
	}
}
