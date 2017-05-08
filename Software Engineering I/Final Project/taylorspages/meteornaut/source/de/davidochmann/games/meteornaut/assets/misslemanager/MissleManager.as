package de.davidochmann.games.meteornaut.assets.misslemanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.ShipEmbed;
	import de.davidochmann.games.meteornaut.graphics.extended.Missle;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.calculator.Calculator;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	//	import flash.utils.Dictionary;
	/**
	 * @author dochmann
	 */
	public class MissleManager extends AbstractAsset 
	{
		private static const MISSLE_SPEED:uint = 15;
		private static const MISSLE_LIFESPAN:uint = 25;
		
//		private static const ADD_TO_MULTIPLIER:uint = 10;
		private static const MAX_MISSLE_COUNT:uint  =  3;
		
		private var mStage:Stage;
		private var mStageWidth:uint;
		private var mStageHeight:uint;
		private var mGameEmbed:GameEmbed;
		private var mClientLayer:Sprite;
		private var mShip:ShipEmbed;
		private var mGameRunning:Boolean;
		
		private var mMultiplier:uint;
		private var mMissleCount:uint;
		private var mMissleAddd:uint;
		private var mMissleCountNew:uint;
		
		private var mI:int;
		
		private var mMissle:Missle;
		private var mMissleX:Number;
		private var mMissleY:Number;
		private var mMissleRotation:int;
		private var mMissleSpread:int;
		
		private var mMissleLibrary:Vector.<Missle>;
		private var mMissleLibraryLength:uint;
		private var mTimer:Timer;
		
		
		private var mFireCooldown:int;
		
		
		
		public function MissleManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{			
			register(Notification.GAME_SETUP);
			register(Notification.GAMEPLAY_START_GAME);
			register(Notification.GAMEPLAY_STOP_GAME);
			register(Notification.GAMEPLAY_NEW_MULTIPLIER);
			register(Notification.GAMEPLAY_COMBO_BROKEN);
			register(Notification.SHIPMANAGER_SHIP_ADDED);
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.FRAMEHANDLER_ENTERFRAME);
			register(Notification.CONTROLS_MOUSE_DOWN);	
			register(Notification.CONTROLS_MOUSE_UP);
			register(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			register(Notification.SCREENLEVEL_SETUP);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.GAMEPLAY_START_GAME);
			unregister(Notification.GAMEPLAY_STOP_GAME);
			unregister(Notification.GAMEPLAY_NEW_MULTIPLIER);
			unregister(Notification.GAMEPLAY_COMBO_BROKEN);
			unregister(Notification.SHIPMANAGER_SHIP_ADDED);
			unregister(Notification.SCREENLEVEL_GAMEEMBED);
			unregister(Notification.FRAMEHANDLER_ENTERFRAME);
			unregister(Notification.CONTROLS_MOUSE_DOWN);	
			unregister(Notification.CONTROLS_MOUSE_UP);
			unregister(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			unregister(Notification.SCREENLEVEL_SETUP);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					mStage		 = args[0] as Stage;
					mStageWidth	 = mStage.stageWidth;
					mStageHeight = mStage.stageHeight;
					break;
				
				case Notification.GAMEPLAY_START_GAME:
					mGameRunning = true;
					break;
				
				case Notification.GAMEPLAY_STOP_GAME:
					mGameRunning = false;
					break;
				
				case Notification.GAMEPLAY_NEW_MULTIPLIER:
					mMultiplier		= args[0] as uint;//					mMultiplier		= args[0] as uint;
					
//					mMissleCountNew = Math.ceil(mMultiplier / ADD_TO_MULTIPLIER);					
					mMissleAddd = mMultiplier == 10 || mMultiplier == 100 ? 1 : 0;

					mMissleCountNew = mMissleCountNew + mMissleAddd;
					mMissleCountNew = mMissleCountNew > MAX_MISSLE_COUNT ? MAX_MISSLE_COUNT : mMissleCountNew;

					if(mMissleCountNew > mMissleCount)
					{
						notify(Notification.TO_STATUSMANAGER_STATUS, "POWER UP", mShip.x, mShip.y - 10);
						notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.POWERUP);
					}

					mMissleCount = mMissleCountNew;
					break;
				
				case Notification.GAMEPLAY_COMBO_BROKEN:
					notify(Notification.TO_STATUSMANAGER_STATUS, "x", mShip.x, mShip.y - 10);
					mMissleCount = mMissleCountNew = 1;
					break;
				
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed = args[0] as GameEmbed;
					mClientLayer = mGameEmbed.mClientLayer;
					break;
				
				case Notification.SCREENLEVEL_SETUP:
					initMissleList();
					initMissleCount();
					initTimer();
										
					notify(Notification.MISSLEMANAGER_NEW_MISSLELIBRARY, mMissleLibrary);
					break;
				
				case Notification.SHIPMANAGER_SHIP_ADDED:
					mShip = args[0] as ShipEmbed;
					break;
		
				case Notification.FRAMEHANDLER_ENTERFRAME:
					moveMissles();
					break;
				
				case Notification.CONTROLS_MOUSE_DOWN:
					createMissle(1.3);
					mTimer.start();
					break;
				
				case Notification.CONTROLS_MOUSE_UP:
					mTimer.stop();
					break;
				
				case Notification.HITMANAGER_HIT_MISSLE_ROCK:
//					removeMissle(args[0] as Missle);
					removeMissleIndex(args[0] as uint);
					break;
			}
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
	
		private function initMissleList():void
		{
			mMissleLibrary = new Vector.<Missle>();
		}	
		
		private function initMissleCount():void
		{
			mMissleCount = mMissleCountNew = 1;
			
		}

		private function initTimer():void
		{
			if(mTimer != null) mTimer.removeEventListener(TimerEvent.TIMER, timerTimerHandler); 
			
			mTimer = new Timer(250, 0);
			mTimer.addEventListener(TimerEvent.TIMER, timerTimerHandler);
		}
		
		private function timerTimerHandler(e:TimerEvent):void
		{
			createMissle(1.3);
		}
		
		
		private function moveMissles():void
		{	
			mFireCooldown = (mFireCooldown < 1) ? 0 : mFireCooldown -1;
			
			mMissleLibraryLength = mMissleLibrary.length;
			
			for(mI = mMissleLibraryLength -1; mI >= 0; --mI)
			{
				mMissle = mMissleLibrary[mI];
				
				if(mMissle.stage == null) mGameEmbed.mClientLayer.addChild(mMissle);
				
				mMissle.mLifespan = (mMissle.mLifespan < 1) ? 0 : mMissle.mLifespan -1;
				
				mMissleX = mMissle.x + mMissle.mDirX; 
				mMissleY = mMissle.y - mMissle.mDirY; 
				
				(mMissleX < -mMissle.width  *.5) ? mMissleX = mStageWidth  + mMissle.width  *.5 : (mMissleX > mStageWidth  + mMissle.width *.5)  ? mMissleX = -mMissle.width  *.5 : mMissleX;
				(mMissleY < -mMissle.height *.5) ? mMissleY = mStageHeight + mMissle.height *.5 : (mMissleY > mStageHeight + mMissle.height *.5) ? mMissleY = -mMissle.height *.5 : mMissleY;
				
				mMissle.x = mMissleX;
				mMissle.y = mMissleY;
				
				if(mMissle.mLifespan == 0) removeMissleIndex(mI);
			}
		}

		private function createMissle(pDistance:Number = 0):void
		{
			if(mFireCooldown != 0) return;

			mMissleRotation = mMissleCount * 10 / mMissleCount;
			mMissleSpread	= mMissleCount == 1 ? 0 : - mMissleRotation * (mMissleCount * .5);
			
			for(mI = 0; mI < mMissleCount; ++mI)
			{	
				mMissle = new Missle();
				mMissleLibrary.push(mMissle);
				
				mMissle.buttonMode 	 = false;
				mMissle.mouseChildren = false;
				mMissle.mouseEnabled  = false;
				
				mMissle.mDirX	 = -MISSLE_SPEED * Calculator.rotationToPositionX(mShip.mBody.rotation + mMissleSpread);
				mMissle.mDirY	 =  MISSLE_SPEED * Calculator.rotationToPositionY(mShip.mBody.rotation + mMissleSpread);
				mMissle.mLifespan = MISSLE_LIFESPAN;
				
				mMissle.x = mShip.x + mMissle.mDirX * pDistance;
				mMissle.y = mShip.y - mMissle.mDirY * pDistance;
				mMissle.rotation = mShip.mBody.rotation + mMissleSpread;
				
				notify(Notification.MISSLEMANAGER_NEW_MISSLELIBRARY, mMissleLibrary);
	
				mFireCooldown = 5;

				mMissleSpread += mMissleRotation;
			}
			
			if(mMissleCount == 1)	   notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.LASER0);
			else if(mMissleCount == 2) notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.LASER1);
			else if(mMissleCount >= 3) notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.LASER2);
		}
		
		private function removeMissleIndex(pIndex:uint):void
		{
			mMissle = mMissleLibrary[pIndex];
			
			mMissleLibrary.splice(pIndex, 1);
			mClientLayer.removeChild(mMissle);
			mMissle = null;
		}
	}
}
