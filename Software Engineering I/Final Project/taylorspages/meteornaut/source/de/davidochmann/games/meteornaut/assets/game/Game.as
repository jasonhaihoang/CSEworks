package de.davidochmann.games.meteornaut.assets.game 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.interfaces.IStageHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import flash.display.Stage;


	/**
	 * @author dochmann
	 */
	
	public class Game extends AbstractAsset implements IStageHolder
	{
		private var mStage:Stage;
		
		
		
		public function Game(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}


		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getStage():Stage
		{
			return mStage;
		}

		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}


		
		/*
		 * PUBLIC FUNCTIONS
		 */

		override public function init():void
		{
			initAssets();
			notify(Notification.GAME_SETUP, mStage);		
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initAssets():void
		{
			var assetListLength:uint = mAssetList.length;
			var asset:AbstractAsset;
			
			for(var i:uint = 0; i < assetListLength; ++i)
			{
				asset = (mAssetList[i] as AbstractAsset);
				asset.init();
			}
		}
	}
}
