package de.davidochmann.games.meteornaut.assets.screenlevelselect
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
	import de.davidochmann.games.meteornaut.graphics.embed.LevelSelectBackEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.LevelSelectEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.LevelSelectLevelEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.namespaces.DEBUG;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	//	import flash.text.TextFieldAutoSize;
	//	import de.davidochmann.utilities.format.Format;

	/**
	 * @author dochmann
	 */
	 
	public class ScreenLevelSelect extends AbstractAsset implements IDisplayHolder
	{
		private static const GRID_DISPOSITION_X:int =   0;
		private static const GRID_DISPOSITION_Y:int = -20;
		private static const BUTTON_ROWS:uint		=   6;
		private static const BUTTON_DISTANCE:uint	=  30;
		
		private var mStage:Stage;
		private var mStageWidth:uint;
		private var mStageHeight:uint;
		private var mSetup:Setup;
		private var mLevelSelectEmbed:LevelSelectEmbed;
		private var mLevelButtonLibrary:Dictionary;
		private var mStats:Stats;
		
				
		
		public function ScreenLevelSelect(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function display():Sprite
		{
			return mLevelSelectEmbed;	
		}
		
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SETUPMANAGER_SETUP);
			register(Notification.STATMANAGER_STATS);
		}

		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SETUPMANAGER_SETUP);
			unregister(Notification.STATMANAGER_STATS);			
		}

		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{	
				case Notification.GAME_SETUP:
					mStage = args[0] as Stage;
					mStageWidth = mStage.stageWidth;
					mStageHeight = mStage.stageHeight;
				
					initLevelSelectEmbed();
					break;
				
				case Notification.STATMANAGER_STATS:
					mStats = args[0] as Stats;
					if(mSetup != null) initLevelButtonText(); 
					break;
								
				case Notification.SETUPMANAGER_SETUP:
					mSetup = args[0] as Setup;				

					initLevelButtonLibrary();
					initLevelButtonText();

					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_LEVELSELECT, this);
					break;
			}
		}

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initLevelSelectEmbed():void 
		{
			mLevelSelectEmbed = new LevelSelectEmbed();			
		}

		private function initLevelButtonLibrary():void
		{
			mLevelButtonLibrary = new Dictionary();
			
			var levelList:Vector.<SetupLevel> = mSetup.levelList();
			var levelListLength:uint = levelList.length;
			var setupLevel:SetupLevel;

			var levelSelectButton:LevelSelectLevelEmbed;

			var lineWidth:uint;
			var gridWidth:int;
			var gridHeight:int;
			
			var gridX:int;
			var gridY:int;

			var textFormatRegular:TextFormat;
			var textFormatBold:TextFormat;

			var backButton:LevelSelectBackEmbed = new LevelSelectBackEmbed();

			for(var i:uint = 0; i < levelListLength; ++i)
			{
				setupLevel = levelList[i] as SetupLevel;
				
				levelSelectButton = new LevelSelectLevelEmbed();
				notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_LEVELSELECT, levelSelectButton, 0);
				
				lineWidth = levelListLength > BUTTON_ROWS ? BUTTON_ROWS : levelListLength;
				gridWidth  = Math.floor(lineWidth * (levelSelectButton.width + BUTTON_DISTANCE) - BUTTON_DISTANCE);
				gridHeight = Math.floor((Math.ceil(levelListLength / BUTTON_ROWS) * (levelSelectButton.height + BUTTON_DISTANCE)) - BUTTON_DISTANCE);
				
				gridX = Math.floor((mStageWidth  - gridWidth)  * .5);
				gridY = Math.floor((mStageHeight - gridHeight) * .5);

				levelSelectButton.x = GRID_DISPOSITION_X + gridX + (setupLevel.getID() % BUTTON_ROWS) * (levelSelectButton.width + BUTTON_DISTANCE);
				levelSelectButton.y = GRID_DISPOSITION_Y + gridY + Math.floor(setupLevel.getID() / BUTTON_ROWS) * (levelSelectButton.height + BUTTON_DISTANCE);
				
				textFormatRegular = new TextFormat("VerdanaRegular");
				textFormatBold	  = new TextFormat("VerdanaBold");
				
				levelSelectButton.mName.defaultTextFormat = textFormatBold;				
				levelSelectButton.mName.setTextFormat(textFormatBold);
				levelSelectButton.mName.text = setupLevel.getName();

//				levelSelectButton.mScore.defaultTextFormat = textFormatRegular;
//				levelSelectButton.mScore.setTextFormat(textFormatRegular);
//				levelSelectButton.mScore.autoSize = TextFieldAutoSize.CENTER;
				
				levelSelectButton.mStar0.visible = false;
				levelSelectButton.mStar1.visible = false;
				levelSelectButton.mStar2.visible = false;
				
				mLevelSelectEmbed.addChild(levelSelectButton);
				
				
				mLevelButtonLibrary[levelSelectButton] = setupLevel;
			}
			
			backButton.x = gridX + gridWidth  - backButton.width  + GRID_DISPOSITION_X;
			backButton.y = gridY + gridHeight + BUTTON_DISTANCE + GRID_DISPOSITION_Y;
			
			backButton.buttonMode = true;
			backButton.mouseChildren = false;
			
			backButton.addEventListener(MouseEvent.ROLL_OVER, backButtonRollOverHandler);
			backButton.addEventListener(MouseEvent.ROLL_OUT, backButtonRollOutHandler);
			backButton.addEventListener(MouseEvent.MOUSE_UP, backButtonMouseUpHandler);
			
			mLevelSelectEmbed.addChild(backButton);
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_LEVELSELECT, backButton, 0);
		}

		private function backButtonRollOverHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 1);	
		}

		private function backButtonRollOutHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 0);
		}

		private function backButtonMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_TITLE);
		}

		private function initLevelButtonText():void
		{
			var levelSelectButton:LevelSelectLevelEmbed;
			var setupLevel:SetupLevel;
			var statsLevel:StatsLevel;
			
			var i:uint;
			
//			var levelScore:String;
			var levelScoreMax:String;
//			var zeros:String;
			
			var levelStarList:Array;
			var levelStarListLength:uint;
			var levelStars:uint;
			var levelStar:Sprite;
			var levelProgress:int = - 1;
			
//			var timeText:String;
			
			var item:Object;
			
			for(item in mLevelButtonLibrary)
			{	
				levelSelectButton = (item as LevelSelectLevelEmbed);
				
				levelStarList = [levelSelectButton.mStar0, levelSelectButton.mStar1, levelSelectButton.mStar2]; 
				levelStarListLength = levelStarList.length;
				
				setupLevel = mLevelButtonLibrary[levelSelectButton];
				statsLevel = mStats.getLevelID(setupLevel.getID());


				if(statsLevel.getComplete() == true) if(setupLevel.getID() > levelProgress) levelProgress = setupLevel.getID();


//				timeText = Format.secondsToTime(statsLevel.getTime()); 
//				levelSelectButton.mTime.text = "Time " + timeText;	
				

				levelScoreMax = String(setupLevel.maxScore());	 

//				zeros = "";
//				for(i = 0; i < levelScoreMax.length; ++i) zeros += "0"; 
//				levelScore = (statsLevel != null) ? (!isNaN(statsLevel.getScore()) ? String(statsLevel.getScore()) : zeros) : zeros;
//
//				levelSelectButton.mScore.text = "Score " + levelScore + " / " + levelScoreMax;
				
				if(statsLevel.getComplete())
				{					
					levelStars = StarCalculator.calculate(statsLevel.getScore(), setupLevel.maxScore());
					
					for(i = 0; i < levelStars; ++i) 
					{
						levelStar = Sprite(levelStarList[i]);
						levelStar.visible = true;
					}
				}
			}
		
			
//			var add:uint = levelProgress == 0 ? 0 : 1;
//		
//			trace("levelProgress: " + levelProgress);
//			
			for(item in mLevelButtonLibrary)
			{	
				levelSelectButton = (item as LevelSelectLevelEmbed);
				setupLevel = mLevelButtonLibrary[levelSelectButton];
				
				if(DEBUG::debug || setupLevel.getID() <= levelProgress + 1) 
				{
					levelSelectButton.mLock.visible = false;
				
					levelSelectButton.addEventListener(MouseEvent.MOUSE_OVER, levelSelectButtonMouseOverHandler);
					levelSelectButton.addEventListener(MouseEvent.MOUSE_OUT, levelSelectButtonMouseOutHandler);
					levelSelectButton.addEventListener(MouseEvent.MOUSE_UP, levelSelectButtonMouseUpHandler);

					levelSelectButton.buttonMode	 = true;
					levelSelectButton.mouseChildren = false;
				}
			}
		}

		private function levelSelectButtonMouseOverHandler(e:MouseEvent):void 
		{
			var levelSelectButton:LevelSelectLevelEmbed = e.currentTarget as LevelSelectLevelEmbed;
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, levelSelectButton, 1);
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.SELECT);
		}

		private function levelSelectButtonMouseOutHandler(e:MouseEvent):void 
		{
			var levelSelectButton:LevelSelectLevelEmbed = e.currentTarget as LevelSelectLevelEmbed;
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, levelSelectButton, 0);
		}

		private function levelSelectButtonMouseUpHandler(e:MouseEvent):void 
		{
			var levelSelectButton:LevelSelectLevelEmbed = e.currentTarget as LevelSelectLevelEmbed;
			var setupLevel:SetupLevel = mLevelButtonLibrary[levelSelectButton] as SetupLevel;
			
			notify(Notification.TO_LEVELSETUP_CREATELEVEL, setupLevel);
		}
	}
}