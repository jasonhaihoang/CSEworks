package de.davidochmann.games.mpshooter.assets.processor 
{
	import de.davidochmann.games.mpshooter.graphics.embed.GameClientLayerEmbed;
	import de.davidochmann.games.mpshooter.graphics.embed.GameEmbed;
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	import de.davidochmann.utilities.stageholder.StageHolder;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author David Ochmann
	 */

	public class Processor implements IAsset
	{	
		private var mID:String;
		private var mData:Object;
		
		private var mGameEmbed:GameEmbed;

		private var mStagePoint:Point;
		private var mStageRectangle:Rectangle;
		private var mBitmapDataMaster:BitmapData;
		private var mBitmapDataSlave:BitmapData;
		
		
		
		public function Processor(pGameEmbed:GameEmbed)
		{
			setGameEmbed(pGameEmbed);
			initHitTestObjects();
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void{}
		
		public function kill():void{}
		
		public function update():void
		{	
			var master:Object = mData.master;
			var slave:Object  = mData.slave;
			
			var statsMaster:Object = mData.stats.master;
			var statsSlave:Object  = mData.stats.slave;
			
			var clientMaster:GameClientLayerEmbed = mGameEmbed.mClientMaster;
			var clientSlave:GameClientLayerEmbed  = mGameEmbed.mClientSlave;			
			
			detectHit(master, statsSlave , statsMaster, clientMaster.mLayerMissles, clientSlave.mLayerShipHitArea);
			detectHit(slave , statsMaster, statsSlave , clientSlave.mLayerMissles , clientMaster.mLayerShipHitArea);
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

		public function getGameEmbed():GameEmbed
		{
			return mGameEmbed;
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

		public function setGameEmbed(pGameEmbed:GameEmbed):void
		{
			mGameEmbed = pGameEmbed;
		}


		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initHitTestObjects():void
		{
			var stg:Stage = StageHolder.getInstance().getStage();
			var stw:uint  = stg.stageWidth;
			var sth:uint  = stg.stageHeight;
			
			mStagePoint 	  = new Point(0, 0);
			mStageRectangle   = new Rectangle(0, 0, stw, sth);
			mBitmapDataMaster = new BitmapData(stw, sth);
			mBitmapDataSlave  = new BitmapData(stw, sth);
		}

		/*
		 * ASSIST FUNCTIONS
		 */
		 
		private function detectHit(pClientObject:Object, pStatsObject0:Object, pStatsObject1:Object, pDrawSprite0:Sprite, pDrawSprite1:Sprite):void
		{
			var energy:int = 0; 
			var kills:uint = 0;
			
			
			var missleList:Array = pClientObject.missles;
			var missleListLength:uint = missleList.length;

			var canvas:Graphics = pDrawSprite0.graphics;
			canvas.lineStyle(0, 0, 1, true);	
			
			var missleObject:Object;
			var prevX:Number;
			var prevY:Number;
			var currentX:Number;
			var currentY:Number;
					
			for(var i:uint = 0; i < missleListLength; ++i)
			{
				missleObject = Object(missleList[i]);

				prevX = missleObject.pX;
				prevY = missleObject.pY;
				currentX = missleObject.x;
				currentY = missleObject.y;
				
				if(isNaN(prevX) || isNaN(prevY)) continue;
				
				canvas.moveTo(prevX, prevY);
				canvas.lineTo(currentX, currentY);
			}
			
			
			mBitmapDataMaster.fillRect(mStageRectangle, 0x00000000);
			mBitmapDataSlave.fillRect(mStageRectangle, 0x00000000);
				
			mBitmapDataMaster.draw(pDrawSprite0);
			mBitmapDataSlave.draw(pDrawSprite1);
			
			canvas.clear();
			
			
			var cooldown:int = (pClientObject.cooldown > 0) ? pClientObject.cooldown-- : 0;
			
			if(mBitmapDataMaster.hitTest(mStagePoint, 1, mBitmapDataSlave, mStagePoint) && cooldown == 0)
			{
				energy 	 = pStatsObject0.energy - 1;
				kills  	 = pStatsObject1.kills;
					
				if(energy < 0){ energy = mData.constants.shipenergy; kills ++; }

				pStatsObject0.energy   = energy;
				pStatsObject1.kills    = kills;
				
				pClientObject.cooldown = mData.constants.shipcooldown;
			}
		}
	}
}
