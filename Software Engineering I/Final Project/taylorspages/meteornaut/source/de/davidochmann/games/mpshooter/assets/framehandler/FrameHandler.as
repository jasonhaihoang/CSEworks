package de.davidochmann.games.mpshooter.assets.framehandler 
{
	import flash.events.Event;
	import de.davidochmann.games.mpshooter.interfaces.IAsset;

	import flash.display.Stage;
	/**
	 * @author dochmann
	 */

	
	public class FrameHandler implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
	
		private var mStage:Stage;
		private var mAsset:IAsset;	
		
		
		
		public function FrameHandler(pStage:Stage):void
		{
			setStage(pStage);
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			mStage.addEventListener(Event.ENTER_FRAME, stageEnterFrameHandler);	
		}

		public function kill():void
		{
			mStage.removeEventListener(Event.ENTER_FRAME, stageEnterFrameHandler);			
		}
		
		public function update():void
		{
			mAsset.update();
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
	
		public function getStage():Stage
		{
			return mStage;
		}

		public function getAsset():IAsset
		{
			return mAsset;
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

		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}

		public function setAsset(pAsset:IAsset):void
		{
			mAsset = pAsset;
		}
		
	
		
		/*
		 * EVENT HANDLER
		 */
		 
		private function stageEnterFrameHandler(e:Event):void 
		{
			update();
		}
	}
}
