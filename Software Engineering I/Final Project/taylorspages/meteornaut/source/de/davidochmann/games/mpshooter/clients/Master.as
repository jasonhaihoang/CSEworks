package de.davidochmann.games.mpshooter.clients
{
	import de.davidochmann.games.mpshooter.assets.executionstack.ExecutionStack;
	import de.davidochmann.games.mpshooter.assets.framehandler.FrameHandler;
	import de.davidochmann.games.mpshooter.assets.mover.Mover;
	import de.davidochmann.games.mpshooter.assets.peerobject.PeerObject;
	import de.davidochmann.games.mpshooter.assets.processor.Processor;
	import de.davidochmann.games.mpshooter.assets.renderer.Renderer;
	import de.davidochmann.games.mpshooter.assets.sender.Sender;
	import de.davidochmann.games.mpshooter.graphics.embed.GameEmbed;
	import de.davidochmann.games.mpshooter.interfaces.IClient;
	import de.davidochmann.utilities.peerconnection.PeerConnection;

	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * @author David Ochmann
	 */
	 	
	public class Master implements IClient
	{	
		private var mID:String;
		private var mData:Object;
		
		private var mStage:Stage;
		private var mGameEmbed:GameEmbed;	
		private var mPeerConnection:PeerConnection;
		
		private var mPeerObject:PeerObject;
		private var mMover:Mover;
		private var mRenderer:Renderer;
		private var mProcessor:Processor;
		private var mSender:Sender;
		private var mExecutionStack:ExecutionStack;
		private var mFrameHandler:FrameHandler;

		
				
		public function Master(pStage:Stage, pPeerConnection:PeerConnection = null)
		{
			setStage(pStage);
			setPeerConnection(pPeerConnection);
		}



		/*
		 * PUBLIC FUNCTIONS
		 */

		public function init(...args:*):void
		{
			initGameEmbed();
			initPeerObject();
			initMover();
			initRenderer();
			initProcessor();
			initSender();
			initExecutionStack();
			initFrameHandler();
		}

		public function kill():void
		{
			mFrameHandler.kill();
		}
		
		public function update():void
		{
			mPeerObject.updateSlaveToMaster(mData);
		}

		public function display():Sprite
		{
			return mGameEmbed;
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

		public function getStage():Stage
		{
			return mStage;
		}

		public function getPeerConnection():PeerConnection
		{
			return mPeerConnection;
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
		 
		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}

		public function setPeerConnection(pPeerConnection:PeerConnection):void
		{
			mPeerConnection = pPeerConnection;
		}

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initGameEmbed():void
		{
			mGameEmbed = new GameEmbed();
		}


		private function initPeerObject():void
		{
			mPeerObject = new PeerObject(mStage);
			mPeerObject.init();
		}

		private function initMover():void
		{
			mMover = new Mover(mStage, Mover.CLIENT_MASTER);
		}

		private function initRenderer():void
		{
			mRenderer = new Renderer(mGameEmbed);
		}

		private function initProcessor():void
		{
			mProcessor = new Processor(mGameEmbed);
		}

		private function initSender():void
		{
			mSender = new Sender(mPeerConnection);
		}

		private function initExecutionStack():void 
		{
			mExecutionStack = new ExecutionStack();
			
			mExecutionStack.setData(mPeerObject.getData());

			mExecutionStack.addAsset(mPeerObject);
			mExecutionStack.addAsset(mMover);
			mExecutionStack.addAsset(mRenderer);
			mExecutionStack.addAsset(mProcessor);
			mExecutionStack.addAsset(mSender);
			
			mExecutionStack.init();
		}

		private function initFrameHandler():void 
		{
			mFrameHandler = new FrameHandler(mStage);
			mFrameHandler.setAsset(mExecutionStack);
			mFrameHandler.init();
		}
	}
}