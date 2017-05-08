package de.davidochmann.games.meteornaut.assets.hitmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.ShipEmbed;
	import de.davidochmann.games.meteornaut.graphics.extended.Missle;
	import de.davidochmann.games.meteornaut.graphics.extended.Rock;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.display.HitTest;
	
	/**
	 * @author dochmann
	 */
	
	public class HitManager extends AbstractAsset 
	{
		private var mGameEmbed:GameEmbed;
		
		private var mShip:ShipEmbed;

		private var mI:int;
		private var mK:int;
		
		private var mRockLibrary:Vector.<Rock>;
		private var mRockLibraryLength:uint;
		
		private var mMissleLibrary:Vector.<Missle>;
		private var mMissleLibraryLength:uint;
		
		private var mRock:Rock;
		private var mMissle:Missle;
		
		
		
		public function HitManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{
			initRockLibrary();
			initMissleLibrary();
			
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.SHIPMANAGER_SHIP_ADDED);
			register(Notification.ROCKMANAGER_NEW_ROCKLIBRARY);
			register(Notification.MISSLEMANAGER_NEW_MISSLELIBRARY);	
			register(Notification.FRAMEHANDLER_ENTERFRAME);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed = args[0] as GameEmbed;
					break;
				
				case Notification.SHIPMANAGER_SHIP_ADDED:
					mShip = args[0] as ShipEmbed;
					break;
					
				case Notification.ROCKMANAGER_NEW_ROCKLIBRARY:
					mRockLibrary = args[0] as Vector.<Rock>;
					break;
					
				case Notification.MISSLEMANAGER_NEW_MISSLELIBRARY:
					mMissleLibrary = args[0] as Vector.<Missle>;
//					mMissleLibraryLength = mMissleLibrary.length;
					break;
					
				case Notification.FRAMEHANDLER_ENTERFRAME:
					detectHit();
					break;	
			}
		}

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initRockLibrary():void
		{
			mRockLibrary = new Vector.<Rock>();
		}

		private function initMissleLibrary():void
		{
			mMissleLibrary = new Vector.<Missle>();
		}

		private function detectHit():void 
		{
			mRockLibraryLength = mRockLibrary.length;
			
			for(mI = 0; mI < mRockLibraryLength; ++mI)
			{
				mRock = mRockLibrary[mI];
				
				if(!mRock.mHit && HitTest.complexHitTestObject(mShip.mBody, mRock.mBody))
					notify(Notification.HITMANAGER_HIT_SHIP_ROCK, mI, mK);
			}
			
			
			mMissleLibraryLength = mMissleLibrary.length;
			mRockLibraryLength	 = mRockLibrary.length;
			
			missleRock : for(mI = 0; mI < mRockLibraryLength; ++mI)
			{
				mRock = mRockLibrary[mI];
					
				for(mK = 0; mK < mMissleLibraryLength; ++mK)
				{
					mMissle = mMissleLibrary[mK];
					
					if(!mRock.mHit && HitTest.complexHitTestObject(mMissle, mRock.mBody))
					{ 
						notify(Notification.HITMANAGER_HIT_MISSLE_ROCK, mK, mI);
						notify(Notification.TO_EXPLOSION_MANAGER_ROCKEXPLOSION, mRock.x, mRock.y, mRock.scaleX, mMissle.rotation); 
						break missleRock; 
					}
				}
			}
		}
	}
}
