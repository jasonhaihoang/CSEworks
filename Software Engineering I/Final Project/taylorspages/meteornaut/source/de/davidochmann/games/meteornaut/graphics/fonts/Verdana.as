package de.davidochmann.games.meteornaut.graphics.fonts 
{
	import de.davidochmann.utilities.fontmanager.IFont;

	import flash.text.Font;

	/**
	 * @author dochmann
	 */
	

	 
	public class Verdana extends Font implements IFont
	{
		[Embed (source="../../../../../../../library/meteornaut/fonts/VerdanaRegular.ttf", 
				fontName="VerdanaRegular",
				embedAsCFF="false",
				unicodeRange="U+00E9, U+2122,U+0020-U+007E,U+00C4,U+00D6,U+00DC,U+00E4,U+00F6,U+00FC,U+00DF,U+2022,U+00E0,U+0097,U+2012-U+2014,U+2018-U+201F,U+00A9,U+00AE") ]
		
		private static var mRegular:Class;
		
		[Embed (source="../../../../../../../library/meteornaut/fonts/VerdanaBold.ttf", 
				fontName="VerdanaBold",
				embedAsCFF="false",
				unicodeRange="U+00E9, U+2122,U+0020-U+007E,U+00C4,U+00D6,U+00DC,U+00E4,U+00F6,U+00FC,U+00DF,U+2022,U+00E0,U+0097,U+2012-U+2014,U+2018-U+201F,U+00A9,U+00AE") ]
		
		private static var mBold:Class;

		
		
		public function Verdana(){}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
				
		public function registerFont():void
		{
			Font.registerFont(mRegular);			Font.registerFont(mBold);
		}
	}
}
