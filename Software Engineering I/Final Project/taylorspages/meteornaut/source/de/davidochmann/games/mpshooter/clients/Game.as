package de.davidochmann.games.mpshooter.clients 
{
	import de.davidochmann.games.mpshooter.assets.statemanager.StateManager;
	import de.davidochmann.games.mpshooter.assets.userinterface.UserInterface;
	import de.davidochmann.games.mpshooter.graphics.embed.UserInterfaceEmbed;
	import de.davidochmann.games.mpshooter.interfaces.IClient;

	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */
	
	public class Game implements IClient
	{
		private var mID:String;
		private var mData:Object;
		private var mDisplay:Sprite;
		private var mClient:IClient;

		private var mConnectionURL:String;
		private var mUserInterfaceEmbed:UserInterfaceEmbed;
		
		private var mUserInterface:UserInterface;
		private var mStateManager:StateManager;
		
		
		
		public function Game()
		{
			initUserInterfaceEmbed();
			initDisplay();
			initStateManager();
		}


		
		/*
		 * PUBLIC FUNCTIONS
		 */

		public function init(...args):void
		{
			mStateManager.callState(args[0]);
		}

		public function kill():void
		{
			mClient.kill();
		}

		public function update():void
		{
			mClient.setData(mData);
			mClient.update();
		}

		public function display():Sprite
		{
			return mDisplay;
		}

		
		
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

		public function getClient():IClient
		{
			return mClient;
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
		
		public function setClient(pClient:IClient):void
		{
			mClient = pClient;
		}
		
		public function setConnectionURL(pConnectionURL:String):void
		{
			mConnectionURL = pConnectionURL;
		}

		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initUserInterfaceEmbed():void
		{
			mUserInterfaceEmbed = new UserInterfaceEmbed();		
		}
		
		private function initDisplay():void
		{
			mDisplay = new Sprite();
			mDisplay.addChild(mUserInterfaceEmbed);			
		}

		
		private function initStateManager():void
		{
			mStateManager = new StateManager();
			mStateManager.init();
			
			mStateManager.addState(this, "userinterface", initUserInterface);
			mStateManager.addState(this, "userinterface", initConnectionURL);
			mStateManager.addState(this, "client"		, initClient);
		}

		
		private function initUserInterface():void
		{
			mUserInterface = new UserInterface(mUserInterfaceEmbed, mConnectionURL);
		}

		private function initConnectionURL():void
		{
			mUserInterface.setConnectionURL(mConnectionURL);
			mUserInterface.init();
		}
		
		private function initClient():void
		{
			mClient.init();
			
			mDisplay.removeChild(mUserInterfaceEmbed);
			mDisplay.addChild(mClient.display());
		}
	}
}
