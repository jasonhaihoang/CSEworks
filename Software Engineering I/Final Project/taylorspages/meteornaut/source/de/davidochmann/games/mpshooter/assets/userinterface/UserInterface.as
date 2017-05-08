package de.davidochmann.games.mpshooter.assets.userinterface 
{
	import de.davidochmann.games.mpshooter.graphics.embed.UserInterfaceEmbed;
	import de.davidochmann.games.mpshooter.graphics.embed.UserInterfaceIntroCopyButtonEmbed;
	import de.davidochmann.games.mpshooter.graphics.embed.UserInterfaceIntroEmbed;
	import de.davidochmann.games.mpshooter.interfaces.IAsset;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	/**
	 * @author dochmann
	 */

	
	public class UserInterface implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
		
		private var mConnectionURL:String;
		private var mUserInterfaceEmbed:UserInterfaceEmbed;
		private var mUserInterfaceIntroEmbed:UserInterfaceIntroEmbed;
		
		
		
		public function UserInterface(pUserInterfaceEmbed:UserInterfaceEmbed, pConnectionURL:String)
		{
			setUserInterfaceEmbed(pUserInterfaceEmbed);	
			setConnectionURL(pConnectionURL);
		}
		
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */

		public function init():void
		{
			initUserInterfaceIntro();
		}

		public function kill():void{}
		
		public function update():void{}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		
		public function getID():String
		{
			return mID;
		}
		
		public function getData():Object
		{
			return mData;
		}
		
		public function getUserInterfaceEmbed():UserInterfaceEmbed
		{
			return mUserInterfaceEmbed;
		}

		public function getConnectionURL():String
		{
			return mConnectionURL;
		}
		
		/*
		 * SETTER FUNCTIONS
		 */
		
		public function setID(pID:String):void
		{
			mID = pID;
		}

		public function setData(pData:Object):void
		{
			mData = pData;
		}
		
		public function setUserInterfaceEmbed(pUserInterfaceEmbed:UserInterfaceEmbed):void
		{
			mUserInterfaceEmbed = pUserInterfaceEmbed;
		}
		
		public function setConnectionURL(pConnectionURL:String):void
		{
			mConnectionURL = pConnectionURL;
		}

		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initUserInterfaceIntro():void
		{
			mUserInterfaceIntroEmbed = mUserInterfaceEmbed.mIntro;
			
			
			var text:TextField  = mUserInterfaceIntroEmbed.mText;
			var textMask:Sprite = mUserInterfaceIntroEmbed.mTextMask;
			
			text.text			   = mConnectionURL;
			textMask.cacheAsBitmap = true;
			text.cacheAsBitmap	   = true;
			text.mask			   = textMask;

			
			var copyButton:UserInterfaceIntroCopyButtonEmbed = mUserInterfaceIntroEmbed.mCopyButton;
			
			copyButton.mouseChildren = false;
			copyButton.buttonMode	 = true;
			
			copyButton.addEventListener(MouseEvent.ROLL_OUT , copyButtonRollOutHandler);
			copyButton.addEventListener(MouseEvent.ROLL_OVER, copyButtonRollOverHandler);
			copyButton.addEventListener(MouseEvent.MOUSE_UP, copyButtonMouseUpHandler);			
		}

		private function copyButtonRollOutHandler(e:MouseEvent):void 
		{
			var copyButton:UserInterfaceIntroCopyButtonEmbed = mUserInterfaceIntroEmbed.mCopyButton;
			copyButton.mStateOut.visible = true;
		}

		private function copyButtonRollOverHandler(e:MouseEvent):void 
		{
			var copyButton:UserInterfaceIntroCopyButtonEmbed = mUserInterfaceIntroEmbed.mCopyButton;
			copyButton.mStateOut.visible = false;
		}

		private function copyButtonMouseUpHandler(e:MouseEvent):void 
		{
			System.setClipboard(mConnectionURL);
		}
	}
}
