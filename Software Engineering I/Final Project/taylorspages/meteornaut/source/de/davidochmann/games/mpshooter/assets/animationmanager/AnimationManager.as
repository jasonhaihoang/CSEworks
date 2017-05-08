package de.davidochmann.games.mpshooter.assets.animationmanager 
{
	import flash.utils.Dictionary;
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	
	/**
	 * @author dochmann
	 */
	
	public class AnimationManager implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
		
		private var mLibrary:Dictionary;
		
		
		
		public function AnimationManager()
		{
					
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			initLibrary();
		}

		public function kill():void
		{
		}
		
		public function update():void
		{
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		
		public function getID():String
		{
			return mID;
		}
		
		public function getData():Object
		{
			return mData;
		}
		
		/*
		 * SETTER FUNCTIONS
		 */
		
		public function setID(pID:String):void
		{
			mID = pID;
		}

		public function setData(pData:Object):void
		{
			mData = pData;
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initLibrary():void 
		{
			mLibrary = new Dictionary();
		}
	}
}
