package de.davidochmann.games.meteornaut.assets.screentitle 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.TitleEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	/**
	 * @author dochmann
	 */
	
	public class ScreenTitle extends AbstractAsset implements IDisplayHolder
	{
		private var mTitleEmbed:TitleEmbed;
		private var mButtonLibrary:Dictionary;
		
		
		
		public function ScreenTitle(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */	
		
		public function display():Sprite
		{
			return mTitleEmbed;
		}
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SCREENSTATS_STARS);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENSTATS_STARS);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initTitleEmbed();
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_TITLE, this);
					break;
					
				case Notification.SCREENSTATS_STARS:
					initStars(Math.max(args[0] as uint, 1));
					break;
			}		
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initTitleEmbed():void 
		{
			mTitleEmbed	   = new TitleEmbed();
			mButtonLibrary = new Dictionary();
			
			mButtonLibrary[mTitleEmbed.mButtonPlay]	 	= ScreenID.SCREEN_LEVELSELECT;
			mButtonLibrary[mTitleEmbed.mButtonStats]	= ScreenID.SCREEN_STATS;
			mButtonLibrary[mTitleEmbed.mButtonControls] = ScreenID.SCREEN_CONTROLS;
			mButtonLibrary[mTitleEmbed.mButtonSettings] = ScreenID.SCREEN_SETTINGS;
			mButtonLibrary[mTitleEmbed.mButtonAbout]	= ScreenID.SCREEN_ABOUT;

			var button:MovieClip;

			for(var object:Object in mButtonLibrary)
			{
				button = (object as MovieClip);
				
				button.buttonMode = true;
				button.mouseChildren = false;
				
				button.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
				button.addEventListener(MouseEvent.ROLL_OUT, buttonRollOutHandler);
				button.addEventListener(MouseEvent.MOUSE_UP, buttonMouseUpHandler);
				
				notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_TITLEBUTTON, button, 0);
			}
		}

		private function buttonRollOverHandler(e:MouseEvent):void 
		{
			var button:MovieClip = e.currentTarget as MovieClip;
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, button, 1);
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.SELECT);
		}

		private function buttonRollOutHandler(e:MouseEvent):void 
		{
			var button:MovieClip = e.currentTarget as MovieClip;
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, button, 0);
		}

		private function buttonMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, mButtonLibrary[e.currentTarget]);
		}
		
		
		/*
		 * STARS FUNCTION
		 */
		 
		private function initStars(pNumStars:uint):void
		{
			var starList:Array = [mTitleEmbed.mStar0, mTitleEmbed.mStar1, mTitleEmbed.mStar2];
			var starListLength:uint = starList.length;
			
			var star:Sprite;
			var i:uint;
			
			for(i = 0; i < starListLength; ++i) 
			{
				star = starList[i] as Sprite;
				star.visible = false; 
			}
			
			for(i = 0; i < pNumStars; ++i)
			{
				star = starList[i] as Sprite;
				star.visible = true;
			}
		}
	}
}
