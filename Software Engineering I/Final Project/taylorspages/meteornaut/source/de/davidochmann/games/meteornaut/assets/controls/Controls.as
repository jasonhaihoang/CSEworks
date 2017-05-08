package de.davidochmann.games.meteornaut.assets.controls 
{
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	/**
	 * @author dochmann
	 */
	
	public class Controls extends AbstractAsset 
	{
		private var mStage:Stage;
		private var mMouseOut:Boolean;
		
		private var mPositionX:Number;
		private var mPositionY:Number;
		
		private var mScreenID:String;
		
		
		public function Controls(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SCREENMANAGER_SCREENSWITCHED);
			register(Notification.GAMEPLAY_START_GAME);
			register(Notification.GAMEPLAY_STOP_GAME);
			register(Notification.FRAMEHANDLER_ENTERFRAME);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENMANAGER_SCREENSWITCHED);
			register(Notification.GAMEPLAY_START_GAME);
			unregister(Notification.GAMEPLAY_STOP_GAME);
			unregister(Notification.FRAMEHANDLER_ENTERFRAME);
		}
		
		override public function call(pStatus:String, ...args:Array):void
		{
			switch(pStatus)
			{
				case Notification.GAME_SETUP:
					mStage = args[0] as Stage;
					
					mPositionX = 0;
					mPositionY = 0;
					break;
				
				case Notification.SCREENMANAGER_SCREENSWITCHED:
					mScreenID = args[0] as String; 
					
					if(mScreenID == ScreenID.SCREEN_GAME) 
					{
						initStageMouseEvents();
					}
					break;
				
				case Notification.GAMEPLAY_START_GAME:
					mStage.focus = mStage;
					initStageKeyboardEvents();			
					break;
				
				case Notification.GAMEPLAY_STOP_GAME:
					removeStageMouseEvents();
					removeStageKeyboardEvents();
					break;
				
				case Notification.FRAMEHANDLER_ENTERFRAME:
					mPositionX = mStage.mouseX;
					mPositionY = mStage.mouseY;
				
					notify(Notification.CONTROLS_MOUSE_POSITION_UPDATE, mPositionX, mPositionY, mMouseOut);
					break;
					
				default:
					removeStageMouseEvents();
					break;
			}
		}



		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initStageKeyboardEvents():void
		{
			mStage.addEventListener(KeyboardEvent.KEY_UP, stageKeyboardEventKeyUpHandler);
		}

		private function removeStageKeyboardEvents():void
		{
			mStage.removeEventListener(KeyboardEvent.KEY_UP, stageKeyboardEventKeyUpHandler);
		}

		private function stageKeyboardEventKeyUpHandler(e:KeyboardEvent):void 
		{
			if(mScreenID != ScreenID.SCREEN_GAME) return; 
			
			switch(e.keyCode)
			{
				case Keyboard.ESCAPE:
					notify(Notification.CONTROLS_KEY_UP_ESCAPE);
					break;
					
				case Keyboard.SPACE:
					notify(Notification.CONTROLS_KEY_UP_SPACE);
					break;
			}
		}

		/*
		 * MOUSEEVENT FUNCTIONS
		 */
		
		private function initStageMouseEvents():void 
		{				
			mStage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
			mStage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			mStage.addEventListener(MouseEvent.MOUSE_OUT, stageMouseOutHandler);
			mStage.addEventListener(MouseEvent.MOUSE_OVER, stageMouseOverHandler);
		}

		private function removeStageMouseEvents():void 
		{
			mStage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
			mStage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			mStage.removeEventListener(MouseEvent.MOUSE_OUT, stageMouseOutHandler);
			mStage.removeEventListener(MouseEvent.MOUSE_OVER, stageMouseOverHandler);
		}

		private function stageMouseDownHandler(e:MouseEvent):void 
		{
			notify(Notification.CONTROLS_MOUSE_DOWN, e.localX, e.localY);
		}
		
		private function stageMouseUpHandler(e:MouseEvent):void 
		{
			notify(Notification.CONTROLS_MOUSE_UP, e.localX, e.localY);
		}

		private function stageMouseOutHandler(e:MouseEvent):void 
		{
			mMouseOut = true;
		}

		private function stageMouseOverHandler(e:MouseEvent):void 
		{
			mMouseOut = false;
		}
	}
}
