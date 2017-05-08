package de.davidochmann.games.mpshooter.abstracts 
{
	import flash.utils.Dictionary;
	
	/**
	 * @author dochmann
	 */
	
	public class AbstractAsset 
	{
		private var mID:String;
		private var mStatus:String;
		private var mLibrary:Dictionary;
		
		
		
		public function AbstractAsset()
		{
			initAssetLibrary();
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void{}
		
		public function kill():void{}
		
		public function addAsset(pAssset:AbstractAsset):void
		{
			
		}

		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getID():String
		{
			return mID;
		}

		public function getStatus():String
		{
			return mStatus;
		}

		/*
		 * SETTER FUNCTIONS
		 */

		public function setID(pID:String):void
		{
			mID = pID;
		}
		
		public function setStatus(pStatus:String):void
		{
			mStatus = pStatus;
		}


		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initAssetLibrary():void 
		{
			mLibrary = new Dictionary();
		}
	}
}
