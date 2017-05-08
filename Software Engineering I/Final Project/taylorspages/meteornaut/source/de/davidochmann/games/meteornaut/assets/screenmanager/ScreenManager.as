package de.davidochmann.games.meteornaut.assets.screenmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.graphics.embed.TransitionEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * @author dochmann
	 */
	
	public class ScreenManager extends AbstractAsset implements IDisplayHolder 
	{
		private var mDisplay:Sprite;

		private var mLabelTransition:ScreenLabelTransition;		
		private var mTransitionEmbed:TransitionEmbed;
		
		private var mScreenLibrary:Dictionary;
		private var mPreviousScreen:Sprite;
		private var mCurrentScreen:Sprite;
		private var mCurrentID:String;
		private var mInTransition:Boolean;
		
		
		
		public function ScreenManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function display():Sprite
		{
			return mDisplay;
		}

		override public function init():void
		{
			initDisplay();
			initTransition();
			initScreenLibrary();
			
			register(Notification.TO_SCREENMANAGER_ADDSCREEN);
			register(Notification.TO_SCREENMANAGER_REMOVESCREEN);
			register(Notification.TO_SCREENMANAGER_SWITCHSCREEN);
		}
		
		override public function kill():void
		{
			unregister(Notification.TO_SCREENMANAGER_ADDSCREEN);
			unregister(Notification.TO_SCREENMANAGER_REMOVESCREEN);
			unregister(Notification.TO_SCREENMANAGER_SWITCHSCREEN);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.TO_SCREENMANAGER_ADDSCREEN:
					addScreen(args[0] as String, args[1] as IDisplayHolder);
					break;
					
				case Notification.TO_SCREENMANAGER_REMOVESCREEN:
					removeScreen(args[0] as String);
					break;		
					
				case Notification.TO_SCREENMANAGER_SWITCHSCREEN:
					switchScreen(args[0] as String);
					break;
			}
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initDisplay():void
		{
			mDisplay = new Sprite();
		}

		/*
		 * TRANSITION FUNCTIONS
		 */

		private function initTransition():void
		{
			mTransitionEmbed = new TransitionEmbed();
			mLabelTransition = new ScreenLabelTransition(mTransitionEmbed, 1, transitionSwap, transitionEnd);
		}

		private function transitionSwap():void
		{
			if(mPreviousScreen != null) mDisplay.removeChild(mPreviousScreen);
			mDisplay.addChildAt(mCurrentScreen, 0);
			
			mCurrentScreen.mouseEnabled  = true;
			mCurrentScreen.mouseChildren = true;
			
			notify(Notification.SCREENMANAGER_SCREENSWITCHED, mCurrentID);
		}

		private function transitionEnd():void
		{
			mInTransition = false;
			
			mTransitionEmbed.stop();	
			mDisplay.removeChild(mTransitionEmbed);
		}


		private function initScreenLibrary():void
		{
			mScreenLibrary = new Dictionary();
		}
		
		private function addScreen(pID:String, pDisplayHolder:IDisplayHolder):void
		{
			mScreenLibrary[pID] = pDisplayHolder.display();	
		}
		
		private function removeScreen(pID:String):void
		{
			if(mScreenLibrary[pID] != undefined ) delete mScreenLibrary[pID];	
		}
		
		private function switchScreen(pID:String):void
		{
			if(mScreenLibrary[pID] != undefined && !mInTransition)
			{
				mPreviousScreen = mCurrentScreen; 
				mCurrentScreen  = (mScreenLibrary[pID] as Sprite);				
				mCurrentID	    = pID;
				
				if(mPreviousScreen != null)
				{
					mInTransition 	= true;
	
					mPreviousScreen.mouseEnabled  = false;
					mPreviousScreen.mouseChildren = false;

					mDisplay.addChild(mTransitionEmbed);
					mTransitionEmbed.play();
				}
				else
					transitionSwap();			
			}
		}
		
//		private function switchScreen(pID:String):void
//		{
//			if(mScreenLibrary[pID] != undefined)
//			{
//				while(mDisplay.numChildren > 0) mDisplay.removeChildAt(0);
//				
//				mCurrentScreen = (mScreenLibrary[pID] as Sprite);				
//				mDisplay.addChild(mCurrentScreen);
//
//				
//				notify(Notification.SCREENMANAGER_SCREENSWITCHED, pID);
//			}
//		}
	}
}
