package de.davidochmann.games.meteornaut.assets.screenstats 
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
	import de.davidochmann.games.meteornaut.graphics.embed.StatsEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.StatsEntry;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.format.Format;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	/**
	 * @author dochmann
	 */
	
	public class ScreenStats extends AbstractAsset implements IDisplayHolder 
	{
		private static const ENTRY_DISTANCE:uint = 30;
		
		private var mStatsEmbed:StatsEmbed;
		private var mButtonBack:MovieClip;
		
		private var mStage:Stage;
		private var mSetup:Setup;
		private var mStats:Stats;
		private var mContent:Sprite;
		private var mMask:Sprite;
		
		private var mDispositionY:int;
		private var mScrollerY:int;
		
		private var mSetupMaxScore:uint;
		private var mSetupMaxCombo:uint;
		
		
		
		public function ScreenStats(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function display():Sprite
		{
			return mStatsEmbed;				
		}
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.STATMANAGER_STATS);	
			register(Notification.SETUPMANAGER_SETUP);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.STATMANAGER_STATS);	
			unregister(Notification.SETUPMANAGER_SETUP);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initStatsEmbed();
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_STATS, this);
					
					mStage = args[0] as Stage;					
					break;	
				
				case Notification.STATMANAGER_STATS:
					mStats = args[0] as Stats;
					initLevelStats();
					break;
								
				case Notification.SETUPMANAGER_SETUP:
					mSetup = args[0] as Setup;
					initLevelStats();
					initScroller();
					break;
			}
		}
		
		
		
		/*	
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initStatsEmbed():void
		{
			mStatsEmbed = new StatsEmbed();
			
			mButtonBack = mStatsEmbed.mButtonBack;
			mContent	= mStatsEmbed.mContent;
			mMask		= mStatsEmbed.mMask;
			
			mMask.visible = false;
			mContent.mask = mMask;
			
			mButtonBack.buttonMode = true;
			mButtonBack.mouseChildren = false;
			
			mButtonBack.addEventListener(MouseEvent.ROLL_OVER, buttonBackRollOverHandler);
			mButtonBack.addEventListener(MouseEvent.ROLL_OUT, buttonBackRollOutHandler);
			mButtonBack.addEventListener(MouseEvent.MOUSE_UP, buttonBackMouseUpHandler);
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_STATSBUTTON, mButtonBack, 0);
		}

		private function buttonBackRollOverHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 1);
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.SELECT);
		}

		private function buttonBackRollOutHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, e.currentTarget as MovieClip, 0);
		}

		private function buttonBackMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_TITLE);
		}
		
		/*
		 * LEVEL FUNCTIONS
		 */
		 
		private function initLevelStats():void
		{
			if(mSetup == null) return;
			
			mSetupMaxScore = 0;
			mSetupMaxCombo = 0;
			
			var content:Sprite = mStatsEmbed.mContent;
			
			var levelList:Vector.<SetupLevel> = mSetup.levelList();
			var levelListLength:uint = levelList.length;
			
			var entry:StatsEntry;

			var setup:SetupLevel;
			var stats:StatsLevel;
			
			var i:uint;
						
			if(content.numChildren == 1) for(i = 0; i < levelListLength + 1; ++i) addEntry((i + 1) * ENTRY_DISTANCE);
			
			for(i = 0; i < levelListLength; ++i)
			{
				entry = content.getChildAt(i + 1) as StatsEntry;

				stats = mStats.getLevelID(i);
				setup = levelList[i] as SetupLevel;
	
				mSetupMaxScore += setup.maxScore();
				mSetupMaxCombo += setup.maxCombo();
	
				insertContent(entry, 
							  "Level " + setup.getName(), 
							  stats.getScore(), 
							  setup.maxScore(), 
							  stats.getCombo(), 
							  setup.maxCombo(), 
							  stats.getTime(), 
							  stats.getComplete());	
			}
			
			insertContent(content.getChildAt(levelListLength + 1) as StatsEntry, 
						  "Complete", 
						  mStats.completeScore(), 
						  mSetupMaxScore, 
						  mStats.completeCombos(), 
						  mSetupMaxCombo, 
						  mStats.completeTime(), 
						  true);
						  
			notify(Notification.SCREENSTATS_STARS, StarCalculator.calculate(mStats.completeScore(), mSetupMaxScore));
		}

		private function addEntry(pY:int):void
		{
			var statsEntry:StatsEntry = new StatsEntry();
			statsEntry.y = pY;
			
			var content:Sprite = mStatsEmbed.mContent;
			var textFormatRegular:TextFormat = new TextFormat("VerdanaRegular");
			
			statsEntry.mLevel.defaultTextFormat = textFormatRegular;
			statsEntry.mLevel.setTextFormat(textFormatRegular);
			statsEntry.mTime.defaultTextFormat = textFormatRegular;
			statsEntry.mTime.setTextFormat(textFormatRegular);
			statsEntry.mCombo.defaultTextFormat = textFormatRegular;
			statsEntry.mCombo.setTextFormat(textFormatRegular);				
			statsEntry.mScore.defaultTextFormat = textFormatRegular;
			statsEntry.mScore.setTextFormat(textFormatRegular);
											
			content.addChild(statsEntry);
		}

		private function insertContent(pEntry:StatsEntry, pName:String, pScore:uint, pMaxScore:uint, pCombo:uint, pMaxCombo:uint, pTime:uint, pComplete:Boolean):void
		{			
			var starList:Array		= [pEntry.mStar0, pEntry.mStar1, pEntry.mStar2];
			var starListLength:uint = starList.length;

			pEntry.mLevel.text = pName;
			pEntry.mScore.text = Format.score(pScore, pMaxScore);
			pEntry.mCombo.text = Format.score(pCombo, pMaxCombo);
			pEntry.mTime.text  = Format.secondsToTime(pTime);
		
			var i:uint; 
		
			var levelStar:Sprite;
			var levelStars:uint = StarCalculator.calculate(pScore, pMaxScore);
			
			pEntry.alpha = .5;
			
			for(i = 0; i < starListLength; ++i){ levelStar = starList[i] as Sprite; levelStar.visible = false; }
			
			if(pComplete)
			{
				pEntry.alpha = 1; 
				for(i = 0; i < levelStars; ++i){ levelStar = starList[i] as Sprite; levelStar.visible = true; }
			}
		}
				
		/*
		 * SCROLLER FUNCTIONS
		 */
		
		private function initScroller():void
		{
			var sbr:Sprite = mStatsEmbed.mScrollerButton;
			var con:Sprite = mStatsEmbed.mContent;
			var msk:Sprite = mStatsEmbed.mMask;
			
			con.cacheAsBitmap = msk.cacheAsBitmap = true;
			con.mask = msk;
			
			mScrollerY = sbr.y;
			
			sbr.buttonMode = true;
			sbr.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarMouseDownHandler);
		}
		
		private function scrollBarMouseDownHandler(e:MouseEvent):void
		{
			mStage.addEventListener(MouseEvent.MOUSE_UP, scrollBarMouseUpHandler);
			mStage.addEventListener(MouseEvent.MOUSE_MOVE, scrollBarMouseMoveHandler);
			mStage.addEventListener(Event.MOUSE_LEAVE, mStageMouseLeaveHandler);
			
			mDispositionY = e.currentTarget.mouseY;
		}
		
		private function mStageMouseLeaveHandler(e:Event):void
		{
			scrollBarMouseUpHandler(null);
		}
		
		private function scrollBarMouseUpHandler(e:MouseEvent):void
		{
			mStage.removeEventListener(MouseEvent.MOUSE_UP, scrollBarMouseUpHandler);
			mStage.removeEventListener(MouseEvent.MOUSE_MOVE, scrollBarMouseMoveHandler);
			mStage.removeEventListener(Event.MOUSE_LEAVE, mStageMouseLeaveHandler);
		}
		
		private function scrollBarMouseMoveHandler(e:MouseEvent):void
		{
			var sba:Sprite = mStatsEmbed;
			
			scroll(mStage.mouseY - mDispositionY - sba.y);			
			e.updateAfterEvent();
		}
		
		private function scroll(pY:int):void
		{			
			var sbr:Sprite = mStatsEmbed.mScrollerButton;
			
			moveTo(pY);
			scrollTo(sbr.y);
		}
		
		/*
		 * SCROLLER POSITION FUNCTIONS
		 */
		
		private function moveTo(pY:int):void
		{	
			var sbg:Sprite = mStatsEmbed.mScrollerLine;
			var sbr:Sprite = mStatsEmbed.mScrollerButton;
		
			var min:int = sbg.y;
			var max:int = sbg.y + sbg.height - sbr.height;
			var sby:int = Math.floor((pY > max) ? max : ((pY < min) ? min : pY));
		
			sbr.y = sby;
		}
		
		/*
		 * CONTENT POSITION FUNCTIONS
		 */
		
		private function scrollTo(pY:int):void
		{	
			var sbr:Sprite = mStatsEmbed.mScrollerButton;
			var sbg:Sprite = mStatsEmbed.mScrollerLine;
			var con:Sprite = mStatsEmbed.mContent;
			var msk:Sprite = mStatsEmbed.mMask;
			
			var bgy:int  = sbg.y;
			var bgh:uint = sbg.height;
			var sbh:uint = sbr.height;
			var cth:uint = con.height + bgy;
			var cmh:uint = msk.height;
			
			var pos:Number = Math.floor(((- (pY - bgy) / (bgh - sbh)) * (cth - cmh)) + mScrollerY);
			
			con.y = pos;
		}
	}
}
