package de.davidochmann.games.mpshooter.assets.renderer 
{
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	import flash.text.TextFieldAutoSize;
	import de.davidochmann.games.mpshooter.graphics.embed.GameEmbed;
	import de.davidochmann.games.mpshooter.graphics.embed.MissleEmbed;
	import de.davidochmann.games.mpshooter.graphics.embed.ShipEmbed;

	import flash.display.Sprite;
	/**
	 * @author David Ochmann
	 */
	
	public class Renderer implements IAsset
	{
		private var mID:String;
		private var mData:Object;
		
		private var mGameEmbed:GameEmbed;
		private var mDisplay:Sprite;

		private var mShipMaster:ShipEmbed;
		private var mShipMasterEnergy:Array;
		private var mShipSlave:ShipEmbed;
		private var mShipSlaveEnergy:Array;
		
		
		
		public function Renderer(pGameEmbed:GameEmbed)
		{
			setGameEmbed(pGameEmbed);
			initShips();
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void{}
		
		public function kill():void{}
		
		public function update():void
		{
			moveShip(mShipMaster, mGameEmbed.mClientMaster.mLayerShipHitArea.mShipHitArea, mData.master);
			moveShip(mShipSlave , mGameEmbed.mClientSlave.mLayerShipHitArea.mShipHitArea , mData.slave);

			moveMissles(mGameEmbed.mClientMaster.mLayerMissles, mData.master);	
			moveMissles(mGameEmbed.mClientSlave.mLayerMissles , mData.slave);

			updateShipUI(mShipMaster, mShipMasterEnergy, mData.stats.master);
			updateShipUI(mShipSlave , mShipSlaveEnergy , mData.stats.slave);			
		}
		
		public function display():Sprite
		{
			return mDisplay;
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

		private function initShips():void
		{
			mShipMaster = mGameEmbed.mClientMaster.mLayerShip.mShip;
			mShipSlave = mGameEmbed.mClientSlave.mLayerShip.mShip;


			mGameEmbed.mClientMaster.mLayerShipHitArea.visible = false;
			mGameEmbed.mClientSlave.mLayerShipHitArea.visible = false;
			
			
			mShipMaster.mInterface.mKills.autoSize = TextFieldAutoSize.LEFT;
			mShipSlave.mInterface.mKills.autoSize = TextFieldAutoSize.LEFT;


			mShipMasterEnergy = [mShipMaster.mInterface.mEnergy00,
								 mShipMaster.mInterface.mEnergy01,
								 mShipMaster.mInterface.mEnergy02,
								 mShipMaster.mInterface.mEnergy03,
								 mShipMaster.mInterface.mEnergy04,
								 mShipMaster.mInterface.mEnergy05,
								 mShipMaster.mInterface.mEnergy06,
								 mShipMaster.mInterface.mEnergy07];
		
			mShipSlaveEnergy  = [mShipSlave.mInterface.mEnergy00,
								 mShipSlave.mInterface.mEnergy01,
								 mShipSlave.mInterface.mEnergy02,
								 mShipSlave.mInterface.mEnergy03,
								 mShipSlave.mInterface.mEnergy04,
								 mShipSlave.mInterface.mEnergy05,
								 mShipSlave.mInterface.mEnergy06,
								 mShipSlave.mInterface.mEnergy07];
		}

		/*
		 * ASSIST FUNCTIONS
		 */
		 
		private function moveShip(pShip:ShipEmbed, pHitArea:Sprite, pObject:Object):void
		{
			if(pObject == null) return;
			
			pShip.x = pHitArea.x = pObject.x;
			pShip.y = pHitArea.y = pObject.y;
			pShip.rotation = pHitArea.rotation = pObject.rotation;
			
			trace("pObject.rotation", pObject.rotation);
			
			pShip.mInterface.rotation = -pObject.rotation;
		}

		private function moveMissles(pContainer:Sprite, pObject:Object):void
		{
			if(pObject == null) return;
		
			
			var missleContainer:Sprite = pContainer;
			while(missleContainer.numChildren > 0) missleContainer.removeChildAt(0);
		
		
			var missleList:Array = pObject.missles;
			var missleListLength:uint  = missleList.length;
						
			var missleEmbed:MissleEmbed;
			var missleObject:Object;

			for(var i:uint = 0; i < missleListLength; ++i)
			{
				missleObject = Object(missleList[i]);
				missleEmbed  = new MissleEmbed();

				missleContainer.addChild(missleEmbed);
				
				missleEmbed.x = missleObject.x;
				missleEmbed.y = missleObject.y;
			}
		}
		
		private function updateShipUI(pShip:ShipEmbed, pShipEnergy:Array, pObject:Object):void
		{
			var energy:int = 8 - int(pObject.energy);
		
			
			var kills:String = String(pObject.kills);
			pShip.mInterface.mKills.text = (kills.length < 3) ? String("000" + kills).slice(-3) : kills;
		
		
			var listLength:uint = pShipEnergy.length;

			var i:uint;
			var item:Sprite;
			
			for(i = 0; i < listLength; ++i)
			{
				item = pShipEnergy[i];
				item.alpha = 1;
			}
			
			for(i = 0; i < energy; ++i)
			{
				item = pShipEnergy[i];
				item.alpha = .5;						
			}
		}
	}
}
