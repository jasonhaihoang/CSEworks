package de.davidochmann.games.meteornaut.assets.screensettings 
{
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.statsmanager.Stats;
	import de.davidochmann.games.meteornaut.graphics.embed.ScrollerButtonVolumeEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.SettingsEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * @author dochmann
	 */
	public class ScreenSettings extends AbstractAsset implements IDisplayHolder
	{
		private var mStage:Stage;
		private var mStats:Stats;
		private var mVolume:uint;
		private var mSettingsEmbed:SettingsEmbed;
		private var mButtonBack:MovieClip;
		private var mScrollerButtonVolume:ScrollerButtonVolumeEmbed;
		private var mScrollerButtonVolumeLabel:TextField;
		
		private var mScrollerX:Number;
		private var mDispositionX:Number;
		private var mVolumePercent:Number;
		
		
		public function ScreenSettings(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		public function display():Sprite
		{
			return mSettingsEmbed;
		}
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.STATMANAGER_STATS);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.STATMANAGER_STATS);	
		}
		
		override public function call(pState:String, ...args:*):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					mStage = args[0] as Stage;
				
					initSettingsEmbed();
					initVolumeScroller();
					moveToPercent(mVolume);
					
					notify(Notification.TO_SOUNDMANAGER_SETVOLUME, mVolume * .01);
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_SETTINGS, this);
					break;
					
				case Notification.STATMANAGER_STATS:
					mStats = args[0] as Stats;
					mVolume = (Math.ceil(mStats.getVolume() * 100));
					
					if(mStage != null) moveToPercent(mVolume);
					break;	
			}
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initSettingsEmbed():void 
		{
			mSettingsEmbed = new SettingsEmbed();
			
			mButtonBack = mSettingsEmbed.mButtonBack;
			
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
		 * VOLUME SCROLLER FUNCTIONS
		 */
		 
		private function initVolumeScroller():void
		{
			mScrollerButtonVolume = mSettingsEmbed.mScrollerButton;
			mScrollerButtonVolumeLabel = mScrollerButtonVolume.mLabel;
			
			var textFormatRegular:TextFormat = new TextFormat("VerdanaRegular");
			
			mScrollerButtonVolumeLabel.defaultTextFormat = textFormatRegular;
			mScrollerButtonVolumeLabel.setTextFormat(textFormatRegular);
			
			mScrollerButtonVolume.buttonMode = true;
			mScrollerButtonVolume.mouseChildren = false;
			mScrollerButtonVolume.addEventListener(MouseEvent.MOUSE_DOWN, scrollBarMouseDownHandler);
			
			mScrollerX = mScrollerButtonVolume.x;
		}
		
		/*
		 * SCROLLER FUNCTIONS
		 */
		
		private function scrollBarMouseDownHandler(e:MouseEvent):void
		{
			mStage.addEventListener(MouseEvent.MOUSE_UP, scrollBarMouseUpHandler);
			mStage.addEventListener(MouseEvent.MOUSE_MOVE, scrollBarMouseMoveHandler);
			mStage.addEventListener(Event.MOUSE_LEAVE, mStageMouseLeaveHandler);
			
			mDispositionX = e.currentTarget.mouseX;
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
			
			notify(Notification.TO_STATSMANAGER_SETVOLUME, mVolumePercent * .01);
			notify(Notification.TO_SOUNDMANAGER_SETVOLUME, mVolumePercent * .01);
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.SELECT);
		}
		
		private function scrollBarMouseMoveHandler(e:MouseEvent):void
		{
			var sba:Sprite = mSettingsEmbed;
			
			moveTo(mStage.mouseX - mDispositionX - sba.x);
			showPercent(mScrollerButtonVolume.x - mSettingsEmbed.mScrollerLine.x);		
			e.updateAfterEvent();
		}
		
		/*
		 * SCROLLER POSITION FUNCTIONS
		 */
		
		private function moveTo(pX:int):void
		{	
			var sbg:Sprite = mSettingsEmbed.mScrollerLine;
			var sbr:Sprite = mSettingsEmbed.mScrollerButton;
		
			var min:int = sbg.x;
			var max:int = sbg.x + sbg.width - sbr.width;
			var sbx:int = Math.floor((pX > max) ? max : ((pX < min) ? min : pX));
		
			sbr.x = sbx;
		}
		
		private function moveToPercent(pPercent:uint):void
		{
			var lineWidth:uint = mSettingsEmbed.mScrollerLine.width - mScrollerButtonVolume.width;
			var xPosition:int = Math.ceil(lineWidth * pPercent *.01);
			
			mScrollerButtonVolume.x = mSettingsEmbed.mScrollerLine.x + xPosition;
			
			showPercent(xPosition);			
		}
		
		private function showPercent(pX:int):void
		{
			var lineWidth:uint = mSettingsEmbed.mScrollerLine.width - mScrollerButtonVolume.width;
			
			mVolumePercent = Math.floor((pX / lineWidth) * 100);
			mScrollerButtonVolumeLabel.text = String(mVolumePercent) + "%";
		}
	}
}
