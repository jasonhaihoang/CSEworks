package de.davidochmann.games.mpshooter.peerobject
{	
	/**
	 * @author dochmann
	 */

	public class PeerObject
	{	
		private const STAGE_WIDTH:uint  = 1024;
		private const STAGE_HEIGHT:uint =  768;
		
		private static var mInstance:PeerObject;
		
		private var mData:Object;
		


		/*
		 * SINGLETON CONSTUCTOR
		 */		
		
		public function PeerObject(pSingletonEnforcer:SingletonEnforcer){}

		public static function getInstance():PeerObject
		{
			if(mInstance == null) mInstance = new PeerObject(new SingletonEnforcer());
			return mInstance;
		}

		public function init():void
		{
			initData();
		}


		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getData():Object
		{
			return mData;
		}
		
		public function getStats():Object
		{
			return mData.stats;
		}
		
		public function getConstants():Object
		{
			return mData.constants;
		}
		
		public function getMaster():Object
		{
			return mData.master;
		}
		
		public function getSlave():Object
		{
			return mData.slave;
		}
	
		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setData(pData:Object):void
		{
			mData = pData;
		}
		
		public function setStats(pStats:Object):void
		{
			mData.stats = pStats;
		}
		
		public function setConstants(pConstants:Object):void
		{
			mData.constants = pConstants;
		}
		
		public function setMaster(pMaster:Object):void
		{
			mData.master = pMaster;
		}
		
		public function setSlave(pSlave:Object):void
		{
			mData.slave = pSlave;
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
//		public function data():Object
//		{
//			return mData;
//		}
//
//		public function stats():Object
//		{
//			return mData.stats;
//		}
//		
//		public function constants():Object
//		{
//			return mData.constants;
//		}
//		
//		public function master():Object
//		{
//			return mData.master;
//		}
//		
//		public function slave():Object
//		{
//			return mData.slave;
//		}

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
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initData():void
		{
			mData = new Object();
			
			mData.constants			   	 = new Object();
			mData.constants.shipdistance = 35;
			mData.constants.shipenergy   =  8;
			mData.constants.shipkills	 =  0;
			mData.constants.shipcooldown =  5;

			mData.stats				  	 = new Object();

			mData.stats.master		  	 = new Object();
			mData.stats.master.kills 	 = mData.constants.shipkills;
			mData.stats.master.energy	 = mData.constants.shipenergy;
			mData.stats.slave		 	 = new Object();
			mData.stats.slave.kills	   	 = mData.constants.shipkills;
			mData.stats.slave.energy 	 = mData.constants.shipenergy;

			mData.master		 	   	 = new Object();
			mData.master.id			     = "master";
			mData.master.x		  	     = STAGE_WIDTH * .5 + mData.constants.shipdistance;
			mData.master.y 		  	     = STAGE_HEIGHT * .5;
			mData.master.rotation	  	 = 0;
			mData.master.missles 	  	 = new Array();
			mData.master.cooldown	 	 = mData.constants.shipcooldown;
			
			mData.slave 		 	 	 = new Object();
			mData.slave.id			     = "slave";			
			mData.slave.x 		 	     = STAGE_WIDTH * .5 - mData.constants.shipdistance;
			mData.slave.y 	 	 	     = STAGE_HEIGHT * .5;
			mData.slave.rotation 	 	 = 180;
			mData.slave.missles  	 	 = new Array();
			mData.slave.cooldown	 	 = mData.constants.shipcooldown;
		}
	}
}

class SingletonEnforcer{}
