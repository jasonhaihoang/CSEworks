package de.davidochmann.games.mpshooter.assets.peerobject
{
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	import flash.display.Stage;
	
	/**
	 * @author dochmann
	 */

	public class PeerObject implements IAsset
	{		
		private var mID:String;
		private var mData:Object;

		private var mStage:Stage;
		
		
		
		public function PeerObject(pStage:Stage):void
		{
			setStage(pStage);
		}



		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		public function init():void
		{
			mData = new Object();
			
			mData.constants			  	 = new Object();
			mData.constants.shipdistance = 35;
			mData.constants.shipenergy 	 =  8;
			mData.constants.shipkills	 =  0;
			mData.constants.shipcooldown =  5;

			mData.stats					 = new Object();

			mData.stats.master		 	 = new Object();
			mData.stats.master.kills 	 = mData.constants.shipkills;
			mData.stats.master.energy	 = mData.constants.shipenergy;
			mData.stats.slave		 	 = new Object();
			mData.stats.slave.kills	 	 = mData.constants.shipkills;
			mData.stats.slave.energy 	 = mData.constants.shipenergy;

			mData.master		 	   	 = new Object();
			mData.master.x		  	 	 = mStage.stageWidth * .5 + mData.constants.shipdistance;
			mData.master.y 		  	 	 = mStage.stageHeight * .5;
			mData.master.rotation	  	 = 0;
			mData.master.missles 	  	 = new Array();
			mData.master.cooldown	 	 = mData.constants.shipcooldown;
			
			mData.slave 		 	 	 = new Object();			
			mData.slave.x 		 	 	 = mStage.stageWidth * .5 - mData.constants.shipdistance;
			mData.slave.y 	 	 	 	 = mStage.stageHeight * .5;
			mData.slave.rotation 	 	 = 180;
			mData.slave.missles  	 	 = new Array();
			mData.master.cooldown	 	 = mData.constants.shipcooldown;
		}
		
		public function kill():void
		{
			mData = null;
		}

		public function update():void{}
		
		public function updateSlaveToMaster(pObject:Object):void
		{
			mData.slave = pObject.slave;
		}
		
		public function updateMasterToSlave(pObject:Object):void
		{
			mData.master = pObject.master;
			mData.stats	 = pObject.stats;
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
	}
}
