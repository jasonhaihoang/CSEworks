package de.davidochmann.games.meteornaut.assets.framehandler 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author dochmann
	 */
	public class FrameHandler extends AbstractAsset 
	{
		private var mStage:Stage;
		private var mPaused:Boolean;
		
		
		
		public function FrameHandler(pID:String, pParent:AbstractAsset)
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
			register(Notification.CONTROLS_KEY_UP_SPACE);
		}

		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.GAMEPLAY_START_GAME);
			unregister(Notification.GAMEPLAY_STOP_GAME);
			unregister(Notification.CONTROLS_KEY_UP_SPACE);
		}
		
		override public function call(pStatus:String, ...args:*):void
		{
			switch(pStatus)
			{
				case Notification.GAME_SETUP:
					mStage = args[0] as Stage;
					break;

				case Notification.GAMEPLAY_START_GAME:
					mPaused = false;
					mStage.addEventListener(Event.ENTER_FRAME, containerEnterFrameHandler);
					break;
				
				case Notification.GAMEPLAY_STOP_GAME:
					pause(false);
					mStage.removeEventListener(Event.ENTER_FRAME, containerEnterFrameHandler);
					break;

				case Notification.CONTROLS_KEY_UP_SPACE:
					togglePause();
					break;
				
				default:
					mStage.removeEventListener(Event.ENTER_FRAME, containerEnterFrameHandler);
					break;		
			}
		}
		
		

		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		public function containerEnterFrameHandler(e:Event):void 
		{
			notify(Notification.FRAMEHANDLER_ENTERFRAME);
		}
		
		/*
		 * PAUSE FUNCTION
		 */
		
		public function togglePause():void
		{
			mPaused = !mPaused;
			pause(mPaused);
		}
		
		private function pause(pPause:Boolean):void
		{
			if(pPause) 
			{
				mStage.removeEventListener(Event.ENTER_FRAME, containerEnterFrameHandler);
				mStage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
				notify(Notification.FRAMEHANDLER_GAMEPAUSED, true);
			}
			else
			{
				mStage.addEventListener(Event.ENTER_FRAME, containerEnterFrameHandler);
				mStage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
				notify(Notification.FRAMEHANDLER_GAMEPAUSED, false);			
			}
		}
		
		private function stageMouseUpHandler(e:MouseEvent):void 
		{
			togglePause();
		}
	}
}
