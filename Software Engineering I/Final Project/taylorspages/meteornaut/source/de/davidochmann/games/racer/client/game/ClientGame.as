package de.davidochmann.games.racer.client.game
{
	import flash.display.Stage;
	import de.davidochmann.games.racer.assets.controls.Controls;
	
	/**
	 * @author dochmann
	 */

	public class ClientGame 
	{
		private var mStage:Stage;
		
		private var mControls:Controls;
		
		
		
		public function ClientGame(pStage:Stage)
		{
			setStage(pStage);
			initControls();	
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
		 * PRIVATE FUNCTIONS
		 */

		private function initControls():void 
		{
			mControls = new Controls(mStage);
		}		
	}
}
