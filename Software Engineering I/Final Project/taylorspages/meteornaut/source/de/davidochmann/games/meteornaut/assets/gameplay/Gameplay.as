package de.davidochmann.games.meteornaut.assets.gameplay
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.setupmanager.SetupLevel;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.assets.statsmanager.Stats;
	import de.davidochmann.games.meteornaut.assets.statsmanager.StatsLevel;
	import de.davidochmann.games.meteornaut.assist.kongregate.Kongregate;
	import de.davidochmann.games.meteornaut.graphics.extended.Rock;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.frametimer.FrameTimer;

	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	/**
	 * @author dochmann
	 */
	public class Gameplay extends AbstractAsset 
	{
		private const COUNTDOWN:uint		   =    3;
		private const DELAY_INITIAL:Number	   = 1000;
		private const DELAY_TIMER_DELAY:Number =  500;
		private const MULTIPLIER_TIME:Number   = 2000;
		private const DEFAULT_SCORE:uint	   =   10;
		private const DEFAULT_PENDING:uint	   =    0;
		private const DEFAULT_MULTIPLIER:uint  =    1;
		
		private var mStage:Stage;
		private var mStageCenterX:int;
		private var mStageCenterY:int;
		private var mKongregate:Kongregate;
		
		private var mRock:Rock;
		private var mRockLibrary:Vector.<Rock>;
		private var mRockCounter:uint;
		
		private var mScore:uint;
		private var mCombo:uint;
		private var mScorePending:uint;
		private var mMultiplier:uint;
		private var mDelayTimer:Timer;
		private var mFrameTimer:FrameTimer;
		private var mGameTimer:Timer;
		
		private var mSetupLevel:SetupLevel;
		private var mStats:Stats;
		private var mStatsLevel:StatsLevel;
		
		
		
		public function Gameplay(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SCREENLEVEL_SETUP);
			register(Notification.FRAMEHANDLER_ENTERFRAME);
			register(Notification.SCREENLEVEL_SETUP_COMPLETE);
			register(Notification.ROCKMANAGER_GAME_OVER);
			register(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			register(Notification.HITMANAGER_HIT_SHIP_ROCK);
			register(Notification.STATMANAGER_STATS);
			register(Notification.ROCKMANAGER_NEW_ROCKCOUNTER);
			register(Notification.ROCKMANAGER_NEW_ROCKLIBRARY);
			register(Notification.SCREENMANAGER_SCREENSWITCHED);
			register(Notification.CONTROLS_KEY_UP_ESCAPE);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENLEVEL_SETUP);
			unregister(Notification.FRAMEHANDLER_ENTERFRAME);
			unregister(Notification.SCREENLEVEL_SETUP_COMPLETE);
			unregister(Notification.ROCKMANAGER_GAME_OVER);
			unregister(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			unregister(Notification.HITMANAGER_HIT_SHIP_ROCK);
			unregister(Notification.STATMANAGER_STATS);
			unregister(Notification.ROCKMANAGER_NEW_ROCKCOUNTER);
			unregister(Notification.ROCKMANAGER_NEW_ROCKLIBRARY);
			unregister(Notification.SCREENMANAGER_SCREENSWITCHED);
			unregister(Notification.CONTROLS_KEY_UP_ESCAPE);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					mStage		  = args[0] as Stage;
					mStageCenterX = mStage.stageWidth * .5;
					mStageCenterY = mStage.stageHeight * .5;
					mKongregate	  = Kongregate.getInstance();
					break;
				
				case Notification.SCREENLEVEL_SETUP:
					initRock();
					initScore();
					initScorePending();
					initMultiplier();
					initDelayTimer();
					initGameTimer();
					initComboTimer();
					break;
				
				case Notification.FRAMEHANDLER_ENTERFRAME:
					mFrameTimer.tick();
					break;
				
				case Notification.SCREENLEVEL_SETUP_COMPLETE:
					mSetupLevel = args[0] as SetupLevel;
					mStatsLevel = mStats.getLevelID(mSetupLevel.getID());
					
					if(mStatsLevel == null) 
					{
						mStatsLevel = new StatsLevel();
						mStatsLevel.setID(mSetupLevel.getID());
					}
					break;
				
				case Notification.ROCKMANAGER_GAME_OVER:
					notify(Notification.GAMEPLAY_STOP_GAME);
					notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_GAMEOVER);
					break;
				
				case Notification.CONTROLS_KEY_UP_ESCAPE:
					notify(Notification.GAMEPLAY_STOP_GAME);
					notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_LEVELSELECT);
					break;
				
				case Notification.HITMANAGER_HIT_MISSLE_ROCK:
					mRock = mRockLibrary[args[1] as uint];
					addPoints(mRock);
					break;

				case Notification.HITMANAGER_HIT_SHIP_ROCK:
					notify(Notification.GAMEPLAY_STOP_GAME);
					break;

				case Notification.STATMANAGER_STATS:
					mStats = args[0] as Stats;				
					break;
				
				case Notification.ROCKMANAGER_NEW_ROCKCOUNTER:
					mRockCounter = args[0] as uint;
					break;
				
				case Notification.ROCKMANAGER_NEW_ROCKLIBRARY:
					mRockLibrary = args[0] as Vector.<Rock>;
					break;
				
				case Notification.SCREENMANAGER_SCREENSWITCHED:
					var screenID:String = args[0] as String;
					
					if(screenID == ScreenID.SCREEN_GAMEOVER)
					{ 
						mGameTimer.stop();
						mFrameTimer.stop(); 
						addPending();
						
						var condition00:Boolean = mScore != 0;
						var condition01:Boolean = isNaN(mStatsLevel.getScore());
						var condition02:Boolean = mScore >  mStatsLevel.getScore();
						var condition03:Boolean = mScore >= mStatsLevel.getScore() && mCombo > mStatsLevel.getCombo();
						var condition04:Boolean = mScore >= mStatsLevel.getScore() && mGameTimer.currentCount < mStatsLevel.getTime();
						
//						var level:String = ("00" + (mStatsLevel.getID() + 1)).slice(-2);
						
						if(mRockCounter == 0 && condition00 && (condition01 || condition02 || condition03 || condition04))
						{
							mStatsLevel.setScore(mScore);
							mStatsLevel.setCombo(mCombo);
							mStatsLevel.setTime(mGameTimer.currentCount);
							
							mStats.calculateCompleteValues();

//							mKongregate.stats("HighScore lvl" + level, mStatsLevel.getScore());
//							mKongregate.stats("Combo lvl" + level, mStatsLevel.getCombo());
//							mKongregate.stats("Time lvl" + level, mStatsLevel.getTime());
//
//							mKongregate.stats("HighScore", mStats.completeScore());
//							mKongregate.stats("Combo", mStats.completeCombos());
//							mKongregate.stats("Time", mStats.completeTime());
							
							mStatsLevel.setComplete(true);

							notify(Notification.GAMEPLAY_NEW_HIGHSCORE);
						}
						 
						notify(Notification.TO_STATSMANAGER_SETLEVEL, mStatsLevel);
					}
					break;	
			}
		}
		
		
		/*
		 *  PRIVATE FUNCTIONS
		 */
		
		private function initRock():void
		{
			mRock = new Rock();
			mRock.scaleX = mRock.scaleY = 0;
		}

		private function initScore():void
		{
			mScore = 0;
		}
		
		private function initScorePending():void
		{
			mScorePending = 0;
		}
		
		private function initMultiplier():void
		{
			mMultiplier = 0;
		}
		
		
		private function initDelayTimer():void
		{
			mDelayTimer = new Timer(DELAY_TIMER_DELAY);
			mDelayTimer.addEventListener(TimerEvent.TIMER, delayTimerTimerHandler);
			
			setTimeout(mDelayTimer.start, DELAY_INITIAL);
		}

		private function delayTimerTimerHandler(e:TimerEvent):void 
		{
			var counter:uint = mDelayTimer.currentCount;
			
			if(counter <= COUNTDOWN)
			{
				notify(Notification.TO_STATUSMANAGER_STATUS, String(COUNTDOWN + 1 - mDelayTimer.currentCount), mStageCenterX, mStageCenterY);
				notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.COUNTDOWN);
			}
			else if(counter >= COUNTDOWN + 1)
			{
				notify(Notification.TO_STATUSMANAGER_STATUS, "GO!", mStageCenterX, mStageCenterY);
				notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.GO);	
				notify(Notification.GAMEPLAY_START_GAME); 
				mDelayTimer.stop();
			}
		}

		
		private function initGameTimer():void
		{			
			mGameTimer = new Timer(1000);
			mGameTimer.start();
		}

		
		private function initComboTimer():void
		{
			if(mFrameTimer != null) mFrameTimer.removeEventListener(TimerEvent.TIMER, comboTimerTimerHandler);
			
			mFrameTimer = new FrameTimer(mStage.frameRate, MULTIPLIER_TIME);
			mFrameTimer.addEventListener(TimerEvent.TIMER, comboTimerTimerHandler);
		}

		private function comboTimerTimerHandler(e:TimerEvent):void 
		{	
			mFrameTimer.stop();			
			if(mMultiplier > 1) notify(Notification.GAMEPLAY_COMBO_BROKEN);				
			addPending();
		}


		private function addPoints(pRock:Rock):void
		{			if(/*mRock.scaleX == pRock.scaleX &&*/ mFrameTimer.running) 
			{
				mMultiplier++;
				notify(Notification.TO_STATUSMANAGER_STATUS, String(mMultiplier) + "x", pRock.x, pRock.y);
				notify(Notification.GAMEPLAY_NEW_MULTIPLIER, mMultiplier, mMultiplier * DEFAULT_SCORE, pRock.x, pRock.y);
			}
			else if(mRock.scaleX != 0) 
			{
				addPending();
			}
	
			mScorePending += DEFAULT_SCORE;			

			mRock = pRock;
			
			mFrameTimer.reset();
			mFrameTimer.start();
		}

		private function addPending():void
		{
			mScore += mScorePending * mMultiplier;

			if(mMultiplier > mCombo) mCombo = mMultiplier;
			
			mScorePending = DEFAULT_PENDING;
			mMultiplier	  = DEFAULT_MULTIPLIER;
			
			notify(Notification.GAMEPLAY_NEW_SCORE, mScore); 
		}
	}
}
