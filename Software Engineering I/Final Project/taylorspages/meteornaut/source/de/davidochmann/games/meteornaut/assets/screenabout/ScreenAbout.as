package de.davidochmann.games.meteornaut.assets.screenabout 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.AboutEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author dochmann
	 */
	
	public class ScreenAbout extends AbstractAsset implements IDisplayHolder
	{
		private var mAboutEmbed:AboutEmbed;
		private var mButtonBack:MovieClip;
		
		
		
		public function ScreenAbout(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		public function display():Sprite
		{
			return mAboutEmbed;
		}
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);	
		}
		
		override public function call(pState:String, ...args:*):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initAboutEmbed();
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_ABOUT, this);
					break;	
			}
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initAboutEmbed():void 
		{
			mAboutEmbed = new AboutEmbed();
			
			mButtonBack = mAboutEmbed.mButtonBack;
			
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
	}
}
