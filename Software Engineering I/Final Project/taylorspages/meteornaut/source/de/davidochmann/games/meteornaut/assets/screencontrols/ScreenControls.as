﻿package de.davidochmann.games.meteornaut.assets.screencontrols 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.ControlsEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author dochmann
	 */
	
	public class ScreenControls extends AbstractAsset implements IDisplayHolder
	{
		private var mControlsEmbed:ControlsEmbed;
		private var mButtonBack:MovieClip;
		
		
		
		public function ScreenControls(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		public function display():Sprite
		{
			return mControlsEmbed;
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
					initControlsEmbed();
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_CONTROLS, this);
					break;	
			}
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initControlsEmbed():void 
		{
			mControlsEmbed = new ControlsEmbed();
			
			mButtonBack = mControlsEmbed.mButtonBack;
			
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
