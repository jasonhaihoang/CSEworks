package de.davidochmann.games.meteornaut.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../library/meteornaut/embed.swf", symbol="soundGameover")]
	 
	public class SoundGameover extends Sound 
	{
		public function SoundGameover(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super(stream, context);
		}
	}
}
