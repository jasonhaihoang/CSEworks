package de.davidochmann.games.meteornaut.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author David Ochmann
	 */
	
	[Embed (source="../../../../../../library/meteornaut/embed.swf", symbol="soundSelect")]
	
	public class SoundSelect extends Sound 
	{
		public function SoundSelect(stream:URLRequest = null, context:SoundLoaderContext = null)
		{
			super(stream, context);
		}
	}
}
