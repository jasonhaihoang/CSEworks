package de.davidochmann.games.mpshooter.assets.mover 
{
	import de.davidochmann.games.mpshooter.interfaces.IAsset;

	import flash.display.Stage;
	import flash.events.MouseEvent;

	/**
	 * @author David Ochmann
	 */

	public class Mover implements IAsset
	{
		public static var CLIENT_MASTER:uint = 0;
		public static var CLIENT_SLAVE:uint  = 1;
		
		private var mID:String;
		private var mData:Object;
		
		private var mStage:Stage;
		private var mStageWidth:uint;
		private var mStageHeight:uint;
		
		private var mClient:uint;
		
		
				
		public function Mover(pStage:Stage, pClient:uint)
		{	
			setStage(pStage);			
			setClient(pClient);
		}



		/*
		 * PUBLIC FUNCTIONS 
		 */
		
		public function init():void
		{
			initStageVariables();
			mStage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
		}
		
		public function kill():void
		{
			mStage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
		}
		
		public function update():void
		{	
			switch(mClient)
			{
				case CLIENT_MASTER:
					moveShip(mData.master, mStage.mouseX, mStage.mouseY);
					moveMissles(mData.master);
					break;
					
				case CLIENT_SLAVE:
					moveShip(mData.slave, mStage.mouseX, mStage.mouseY);
					moveMissles(mData.slave);
					break;
			}
		}


		
		/*
		 * GETTER FUCTIONS
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

		public function getClient():uint
		{
			return mClient;
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

		public function setClient(pClient:uint):void
		{
			mClient = pClient;
		}

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initStageVariables():void
		{		
			mStageWidth = mStage.stageWidth;
			mStageHeight = mStage.stageHeight;
		}

		/*
		 * ASSIST FUNCTIONS
		 */
		
		private function moveShip(pClientObject:Object, pMouseX:Number, pMouseY:Number):void
		{
			var msx:Number = (pMouseX >  mStageWidth) ?  mStageWidth : (pMouseX < 0) ? 0 : pMouseX;
			var msy:Number = (pMouseY > mStageHeight) ? mStageHeight : (pMouseY < 0) ? 0 : pMouseY;
			
			var dmx:Number = msx - pClientObject.x;
			var dmy:Number = msy - pClientObject.y;
			
			var spx:Number = dmx * .06;
			var spy:Number = dmy * .06;
						
			pClientObject.x = pClientObject.x + spx;
			pClientObject.y = pClientObject.y + spy;
			
			pClientObject.rotation = (Math.atan2(dmy, dmx)) * (180 / Math.PI);
			
			trace("msx:", msx, "msy:", msy, "cox", pClientObject.x, "coy", pClientObject.y);
		}

		private function moveMissles(pClientObject:Object):void
		{			
			var missleList:Array 	  = pClientObject.missles;
			var missleListLength:uint = missleList.length;
			
			var missleObject:Object;

			for(var i:uint = 0; i < missleListLength; ++i)
			{	
				missleObject = Object(missleList[i]);

				missleObject.pX = missleObject.x;
				missleObject.pY = missleObject.y;
				
				missleObject.x = missleObject.x + missleObject.dirX;
				missleObject.y = missleObject.y - missleObject.dirY;
								
				if(missleObject.x > mStageWidth || missleObject.x < 0 || missleObject.y > mStageHeight || missleObject.y < 0) 
				{ missleList.splice(i, 1); break; }
			}
		}

		private function createMissle(pClientObject:Object, pMouseX:Number, pMouseY:Number, pDistance:Number = 0):void
		{
			var msl:Object = new Object();
			
			var rot:Number = pClientObject.rotation;
			var lst:Array = pClientObject.missles;
			lst.push(msl);
						
			var ang:Number = rot + 180;
			ang = (ang < 0) ? (ang + 360) : (ang > 360) ? ang - 360 : ang;
			
			msl.dirX = -14 * Math.cos(Math.PI / 180 * ang);
			msl.dirY =  14 * Math.sin(Math.PI / 180 * ang);

			msl.x = pMouseX + msl.dirX * pDistance;
			msl.y = pMouseY - msl.dirY * pDistance;
		}

		/*
		 * EVENT HANDLER
		 */
		 
		private function stageMouseUpHandler(e:MouseEvent):void
		{
			if(mClient == CLIENT_MASTER) createMissle(mData.master, mData.master.x, mData.master.y, 1.3);
			else if(mClient == CLIENT_SLAVE) createMissle(mData.slave, mData.slave.x, mData.slave.y, 1.3);
		}
	}
}
