package de.davidochmann.games.meteornaut.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../library/meteornaut/embed.swf", symbol="soundGo")]
	
	public class SoundGo extends Sound 
	{
		public function SoundGo(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super(stream, context);
		}
	}
}
