package de.davidochmann.utilities.fontmanager 
{
	/**
	 * @author dochmann
	 */
	
	public class FontManager 
	{
		private static var mInstance:FontManager;
		
		
		
		/*
		 * SINGLETON CONSTRUCTOR
		 */
		
		public function FontManager(pSingletonEnforcer:SingletonEnforcer){}
		
		public static function getInstance():FontManager
		{
			if(mInstance == null) mInstance = new FontManager(new SingletonEnforcer());
			return mInstance;
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function registerFont(pFont:IFont):void
		{
			pFont.registerFont();
		}
	}
}

class SingletonEnforcer{}