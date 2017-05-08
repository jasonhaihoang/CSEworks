package de.davidochmann.games.meteornaut.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../library/meteornaut/embed.swf", symbol="soundLaser0")]
	 
	public class SoundLaser0 extends Sound 
	{
		public function SoundLaser0(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super(stream, context);
		}
	}
}
