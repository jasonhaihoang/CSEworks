package de.davidochmann.games.meteornaut.assets.statsmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.setupmanager.Setup;
	import de.davidochmann.games.meteornaut.assets.setupmanager.SetupLevel;
//	import de.davidochmann.games.meteornaut.assist.kongregate.Kongregate;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.Stage;
	import flash.net.SharedObject;
	import flash.net.registerClassAlias;
	/**
	 * @author David Ochmann
	 */
	 
	public class StatsManager extends AbstractAsset 
	{
		private static const SHAREDOBJECT_NAME:String	 = "meteornaut";
		private static const SHAREDOBJECT_VERSION:String = "002";
		
		private var mSharedObject:SharedObject;
		private var mStats:Stats;
		private var mSetup:Setup;
//		private var mKongregate:Kongregate;
		private var mStage:Stage;
		
		
		public function StatsManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS 
		 */
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SETUPMANAGER_SETUP);
			register(Notification.TO_STATSMANAGER_SETVOLUME);
			register(Notification.TO_STATSMANAGER_SETLEVEL);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SETUPMANAGER_SETUP);
			unregister(Notification.TO_STATSMANAGER_SETVOLUME);
			unregister(Notification.TO_STATSMANAGER_SETLEVEL);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					mStage = args[0];			
					initStats();
//					initKongregate();
					break;
				
				case Notification.SETUPMANAGER_SETUP:
					mSetup = args[0] as Setup;
					initStatsCorrection();
					break;
				
				case Notification.TO_STATSMANAGER_SETVOLUME:
					mStats.setVolume(args[0] as Number);
					break;
				
				case Notification.TO_STATSMANAGER_SETLEVEL:
					var level:StatsLevel = args[0] as StatsLevel;
					addLevel(level);
					break;				
			}
		}
		

		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initStats():void
		{
			registerClassAlias("Stats", Stats);
			registerClassAlias("Level", StatsLevel);
			
			var localObjectName:String = SHAREDOBJECT_NAME;
			
			mSharedObject = SharedObject.getLocal(localObjectName);
			if(mSharedObject.data.version != SHAREDOBJECT_VERSION) mSharedObject.clear();
			
			mStats = mSharedObject.data.stats as Stats;

			if(mStats == null || mStats.mLevelLibrary == null) 
			{
				mStats = new Stats();
				mStats.setVolume(.1);
			}
			
			mSharedObject.data.stats   = mStats;
			mSharedObject.data.version = SHAREDOBJECT_VERSION;
			mSharedObject.flush();
			
			notify(Notification.STATMANAGER_STATS, mStats);
		}
		
		/*
		 * KONGREGATE FUNCTION
		 */
		
//		private function initKongregate():void 
//		{
//			mKongregate = Kongregate.getInstance();
//			mKongregate.init(mStage);
//		}

		private function initStatsCorrection():void
		{
			if(mStats == null) return;
			
			var levelList:Vector.<SetupLevel> = mSetup.levelList();
			var levelListLength:uint = levelList.length;
			
			var setupLevel:SetupLevel;
			var setupLevelID:uint;
			var statsLevel:StatsLevel;
			var clearLevel:Boolean;
			
			for(var i:uint = 0; i < levelListLength; ++i)
			{
				setupLevel = levelList[i];
				setupLevelID = setupLevel.getID();
				
				statsLevel = mStats.getLevelID(setupLevelID);
				
				if(statsLevel == null) clearLevel = true; 
				else if(statsLevel.getScore() > setupLevel.maxScore()) clearLevel = true;
				
				if(clearLevel) 
				{
					statsLevel = new StatsLevel();
					statsLevel.setID(setupLevelID);
					
					mStats.setLevelID(setupLevelID, statsLevel);
				}
			}
		}

		private function addLevel(pLevel:StatsLevel):void
		{			
			mStats.setLevelID(pLevel.getID(), pLevel);		
			notify(Notification.STATMANAGER_STATS, mStats); 
			
			mSharedObject.data.stats = mStats;
			mSharedObject.flush();
		}
	}
}