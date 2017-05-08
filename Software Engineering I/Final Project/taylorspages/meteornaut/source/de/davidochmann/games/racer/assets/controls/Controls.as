package de.davidochmann.games.racer.assets.controls 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	/**
	 * @author dochmann
	 */
	 
	public class Controls 
	{
		private var mStage:Stage;
		private var mKeyList:Array;
		
		
		
		public function Controls(pStage:Stage)
		{
			setStage(pStage);
			initKeyList();
			initStageEvents();
		}
		
		
		
		public function pressed(pKeyCode:uint):Boolean
		{
			var kll:uint = mKeyList.length;
			var psd:Boolean = false;
			
			var itm:uint;
			
			for(var i:uint = 0; i < kll; ++i)
			{
				itm = uint(mKeyList[i]);
				if(pKeyCode == itm){ psd = true; break; } 
			}
			
			return psd;	
		}
		
		public function pressedList():Array
		{
			return mKeyList;
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

		private function initKeyList():void 
		{
			mKeyList = new Array();
		}

		private function initStageEvents():void
		{
			mStage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDownHandler);
			mStage.addEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler);
		}

		private function stageKeyDownHandler(e:KeyboardEvent):void 
		{
			var key:uint = e.keyCode;
			var kll:uint = mKeyList.length;
			
			var itm:uint;
			var inl:Boolean;
			
			for(var i:uint = 0; i < kll; ++i)
			{
				itm = uint(mKeyList[i]);
				if(itm == key){ inl = true; break; }
			}
			
			if(!inl) mKeyList.push(key);		
		}

		private function stageKeyUpHandler(e:KeyboardEvent):void 
		{
			var key:uint = e.keyCode;
			var kll:uint = mKeyList.length;
			
			var itm:uint;
			
			for(var i:uint = 0; i < kll; ++i)
			{
				itm = uint(mKeyList[i]);
				if(itm == key) mKeyList.splice(i, 1); 
			}
		}
	}
}
