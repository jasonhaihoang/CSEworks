package de.davidochmann.games.meteornaut.assets.screengameover
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.setupmanager.Setup;
	import de.davidochmann.games.meteornaut.assets.setupmanager.SetupLevel;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.assets.statsmanager.Stats;
	import de.davidochmann.games.meteornaut.assets.statsmanager.StatsLevel;
	import de.davidochmann.games.meteornaut.assist.starcalculator.StarCalculator;
	import de.davidochmann.games.meteornaut.graphics.embed.GameOverEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.namespaces.DEBUG;
	import de.davidochmann.utilities.format.Format;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;

	/**
	 * @author dochmann
	 */
	public class ScreenGameOver extends AbstractAsset implements IDisplayHolder 
	{
		private var mGameOverEmbed:GameOverEmbed;
		
		private var mSetupLevel:SetupLevel;
		private var mStatsLevel:StatsLevel;
		private var mStats:Stats;
		private var mSetup:Setup;
		
		
		
		public function ScreenGameOver(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function display():Sprite
		{
			return mGameOverEmbed;
		}
		
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.STATMANAGER_STATS);
			register(Notification.SCREENLEVEL_SETUP_COMPLETE);
			register(Notification.SETUPMANAGER_SETUP);
			register(Notification.GAMEPLAY_NEW_HIGHSCORE);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENLEVEL_SETUP_COMPLETE);
			unregister(Notification.STATMANAGER_STATS);
			unregister(Notification.SETUPMANAGER_SETUP);
			unregister(Notification.GAMEPLAY_NEW_HIGHSCORE);
		}

		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initGameOverEmbed();
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_GAMEOVER, this);
					break;

				case Notification.SCREENLEVEL_SETUP_COMPLETE:
					mSetupLevel = args[0] as SetupLevel;
					mStatsLevel = mStats.getLevelID(mSetupLevel.getID());
					break;
					
				case Notification.SETUPMANAGER_SETUP:
					mSetup = args[0] as Setup;			
					break;
	
				case Notification.STATMANAGER_STATS:
					mStats = args[0] as Stats;
					if(mSetupLevel != null) 
					{
						initScreenStats();
						initScreenText();
					}
					break;
					
				case Notification.GAMEPLAY_NEW_HIGHSCORE:
					setTimeout(notify, 500, Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, mGameOverEmbed.mFloppy, 0);
					break;
			}	
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initGameOverEmbed():void
		{
			mGameOverEmbed = new GameOverEmbed();

			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_GAMEOVER, mGameOverEmbed.mFloppy);


			mGameOverEmbed.mMenuButton.buttonMode = true;
			mGameOverEmbed.mMenuButton.mouseChildren = false;

			mGameOverEmbed.mMenuButton.addEventListener(MouseEvent.ROLL_OVER, gameOverButtonRollOverHandler);
 			mGameOverEmbed.mMenuButton.addEventListener(MouseEvent.ROLL_OUT, gameOverButtonRollOutHandler);
			mGameOverEmbed.mMenuButton.addEventListener(MouseEvent.MOUSE_UP, menuButtonMouseUpHandler);

			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_GAMEOVER, mGameOverEmbed.mMenuButton);

			
			mGameOverEmbed.mRepeatButton.buttonMode = true;
			mGameOverEmbed.mRepeatButton.mouseChildren = false;

			mGameOverEmbed.mRepeatButton.addEventListener(MouseEvent.ROLL_OVER, gameOverButtonRollOverHandler);
 			mGameOverEmbed.mRepeatButton.addEventListener(MouseEvent.ROLL_OUT, gameOverButtonRollOutHandler);
			mGameOverEmbed.mRepeatButton.addEventListener(MouseEvent.MOUSE_UP, repeatButtonMouseUpHandler);
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_GAMEOVER, mGameOverEmbed.mRepeatButton);
			
			
			mGameOverEmbed.mNextButton.mouseChildren = false;
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_GAMEOVER, mGameOverEmbed.mNextButton);
			
			
			mGameOverEmbed.mLockButton.mouseChildren = false; 
		}

		private function gameOverButtonRollOverHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 1);	
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.SELECT);	
		}

		private function gameOverButtonRollOutHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 0);			
		}

		private function menuButtonMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_LEVELSELECT);
		}

		private function repeatButtonMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_LEVELSETUP_CREATELEVEL, mSetupLevel);
		}


		private function initScreenStats():void
		{
			var textFormatRegular:TextFormat = new TextFormat("VerdanaRegular");
			var textFormatBold:TextFormat	 = new TextFormat("VerdanaBold");
			
			mGameOverEmbed.mScore.defaultTextFormat = textFormatRegular;
			mGameOverEmbed.mScore.setTextFormat(textFormatRegular);

			mGameOverEmbed.mMaxCombo.defaultTextFormat = textFormatRegular;
			mGameOverEmbed.mMaxCombo.setTextFormat(textFormatRegular);

			mGameOverEmbed.mTime.defaultTextFormat = textFormatRegular;
			mGameOverEmbed.mTime.setTextFormat(textFormatRegular);
						
			mGameOverEmbed.mTitle.defaultTextFormat = textFormatBold;
			mGameOverEmbed.mTitle.setTextFormat(textFormatBold);
			
			mGameOverEmbed.mLevel.defaultTextFormat = textFormatBold;
			mGameOverEmbed.mLevel.setTextFormat(textFormatBold);
			
			mGameOverEmbed.mStar0.visible = false;
			mGameOverEmbed.mStar1.visible = false;
			mGameOverEmbed.mStar2.visible = false;
		}

		private function initScreenText():void 
		{
			var titleCompleteText:String = (mStatsLevel.mComplete) ? "COMPLETE!" : "GAME OVER";
			titleCompleteText = mStatsLevel.mComplete && mSetupLevel.maxScore() == mStatsLevel.getScore() ? "PERFECT!" : titleCompleteText;
			
			mGameOverEmbed.mTitle.text = titleCompleteText;
			mGameOverEmbed.mLevel.text = "Level " + mSetupLevel.getName();

			mGameOverEmbed.mTime.text = Format.secondsToTime(mStatsLevel.getTime());			

		
			mGameOverEmbed.mScore.text = Format.score(mStatsLevel.getScore(), mSetupLevel.maxScore());
			mGameOverEmbed.mMaxCombo.text = Format.score(mStatsLevel.getCombo(), mSetupLevel.maxCombo());

			
			var levelStarList:Array = [mGameOverEmbed.mStar0, mGameOverEmbed.mStar1, mGameOverEmbed.mStar2];

			var levelStar:Sprite;
			var levelStars:uint;
			
			if(mStatsLevel.getComplete())
			{
				levelStars = StarCalculator.calculate(mStatsLevel.getScore(), mSetupLevel.maxScore());
				
				for(var i:uint = 0; i < levelStars; ++i) 
				{
					levelStar = Sprite(levelStarList[i]);
					levelStar.visible = true;
				}
			}
			
			if(DEBUG::debug || (mStatsLevel != null && mStatsLevel.getComplete()))
			{
				mGameOverEmbed.mLockButton.visible		 = false;
				mGameOverEmbed.mNextButton.buttonMode	 = true;
	
				mGameOverEmbed.mNextButton.addEventListener(MouseEvent.ROLL_OVER, gameOverButtonRollOverHandler);
	 			mGameOverEmbed.mNextButton.addEventListener(MouseEvent.ROLL_OUT, gameOverButtonRollOutHandler);			
				mGameOverEmbed.mNextButton.addEventListener(MouseEvent.MOUSE_UP, nextButtonMouseUpHandler);
			}
			else
			{
				mGameOverEmbed.mLockButton.visible		 = true;
				mGameOverEmbed.mNextButton.buttonMode	 = false;
				
				mGameOverEmbed.mNextButton.removeEventListener(MouseEvent.ROLL_OVER, gameOverButtonRollOverHandler);
	 			mGameOverEmbed.mNextButton.removeEventListener(MouseEvent.ROLL_OUT, gameOverButtonRollOutHandler);			
				mGameOverEmbed.mNextButton.removeEventListener(MouseEvent.MOUSE_UP, nextButtonMouseUpHandler);
			}
		}
		
		private function nextButtonMouseUpHandler(e:MouseEvent):void 
		{
			if(mSetupLevel.getID() + 1 < mSetup.levelList().length)
			{
				var setupLevel:SetupLevel = mSetup.receiveLevelID(mSetupLevel.getID() + 1);
				notify(Notification.TO_LEVELSETUP_CREATELEVEL, setupLevel);
			}
			else 
				notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_LEVELSELECT); 
		}
	}
}
