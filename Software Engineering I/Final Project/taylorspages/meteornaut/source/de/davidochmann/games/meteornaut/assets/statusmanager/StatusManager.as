package de.davidochmann.games.meteornaut.assets.statusmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.extended.Status;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	/**
	 * @author dochmann
	 */
	
	public class StatusManager extends AbstractAsset 
	{
		private var mGameEmbed:GameEmbed;
		private var mClientLayer:Sprite;
		
		private var mStatusLibrary:Dictionary; 
		
		
		
		public function StatusManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS 
		 */
		
		override public function init():void
		{
			initStatusLibrary();
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.TO_STATUSMANAGER_STATUS);
			register(Notification.ANIMATIONMANAGER_ANIMATION_END);
		}

		override public function kill():void
		{
			unregister(Notification.SCREENLEVEL_GAMEEMBED);
			unregister(Notification.TO_STATUSMANAGER_STATUS);
			unregister(Notification.ANIMATIONMANAGER_ANIMATION_END);
		}
				
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed = args[0] as GameEmbed;
					mClientLayer = mGameEmbed.mClientLayer;
					break;
								
				case Notification.TO_STATUSMANAGER_STATUS:
					addStatus(args[0] as String, args[1] as Number, args[2] as Number);
					break;
				
				case Notification.ANIMATIONMANAGER_ANIMATION_END:
					if(args[0] is Status) removeStatus(args[0]);
					break;	
			}
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initStatusLibrary():void 
		{
			mStatusLibrary = new Dictionary();
		}

		private function addStatus(pText:String, pX:Number, pY:Number):void
		{
			var status:Status = new Status();
			
			mStatusLibrary[status] = status; 
			
			status.x = pX;
			status.y = pY;
			status.mouseEnabled = false;
			status.buttonMode = false;
			status.mouseChildren = false;
			status.mText.mTextField.text = pText;
			
			
			var textFormat:TextFormat = new TextFormat("VerdanaBold");
			
			status.mText.mTextField.embedFonts = true;
			status.mText.mTextField.defaultTextFormat = textFormat; 
			status.mText.mTextField.setTextFormat(textFormat);
			

			mClientLayer.addChild(status);
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, "status", status);
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, status);	
		}
		
		private function removeStatus(pStatus:Status):void
		{
			if(mStatusLibrary[pStatus] != undefined)
			{
				delete mStatusLibrary[pStatus];
				mClientLayer.removeChild(pStatus);
				
				notify(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION, pStatus);				
			}			
		}
	}
}
