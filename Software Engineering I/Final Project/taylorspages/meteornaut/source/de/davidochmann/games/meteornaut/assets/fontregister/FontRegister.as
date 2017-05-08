package de.davidochmann.games.meteornaut.assets.fontregister 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.graphics.fonts.Verdana;
	import de.davidochmann.utilities.fontmanager.FontManager;
	/**
	 * @author dochmann
	 */
	public class FontRegister extends AbstractAsset 
	{
		private var mFontManager:FontManager;
		
		
		
		public function FontRegister(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function init():void
		{
			mFontManager = FontManager.getInstance();
			mFontManager.registerFont(new Verdana());
		}
	}
}
