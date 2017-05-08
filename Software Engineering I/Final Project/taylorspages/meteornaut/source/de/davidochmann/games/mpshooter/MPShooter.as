package de.davidochmann.games.mpshooter 
{
	import net.hires.debug.Stats;

	import de.davidochmann.games.mpshooter.clients.Game;
	import de.davidochmann.games.mpshooter.clients.Master;
	import de.davidochmann.games.mpshooter.clients.Slave;
	import de.davidochmann.utilities.peerconnection.PeerConnection;
	import de.davidochmann.utilities.peerconnection.event.PeerConnectionEvent;
	import de.davidochmann.utilities.stageholder.StageHolder;

	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.utils.ByteArray;
	/**
	 * @author David Ochmann
	 */
	
	public class MPShooter extends Sprite 
	{
		private static const SERVER_ADDRESS:String = "rtmfp://stratus.rtmfp.net/b95d4d576660eaadae2e5464-ddaf8190f09d/";
		private static const DEVELOPER_KEY:String  = "b95d4d576660eaadae2e5464-ddaf8190f09d";

		private var mSWFAddressInit:Boolean;
		private var mStageHolder:StageHolder;
		private var mPeerConnection:PeerConnection;
		
		private var mFingerprint:String;

		private var mGame:Game;
		private var mMaster:Master;
		private var mSlave:Slave;

		private var mByteArray:ByteArray;
		private var mReceiveObject:Object;

		private var mStats:Stats;



		public function MPShooter()
		{
			initSWFAddress();
		}	

		
		
		/*
		 * SWFADDRESS FUNCTIONS
		 */
		
		private function initSWFAddress():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfAddressChangeHandler);
		}
		
		private function swfAddressChangeHandler(e:SWFAddressEvent):void
		{	
			if(!mSWFAddressInit){ mSWFAddressInit = true; init(); }
		}

		private function init():void
		{
			initStageHolder();
			initFingerprint();
			initByteArray();
			initPeerConnection();
			initStageEvents();
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initStageHolder():void
		{
			mStageHolder = StageHolder.getInstance();
			mStageHolder.init(stage);
		}
		
		
		
		/*
		 * GAME INTERFACE FUNCTIONS
		 */

		private function initFingerprint():void
		{
			var prm:String = "?" + String(SWFAddress.getValue().split("?")[1]);
			var fpr:String = ((prm.split("fpr=") as Array)[1] as String);
			
			mFingerprint = (fpr != null) ? String(fpr) : null;
		}


		private function initByteArray():void
		{
			mByteArray = new ByteArray();
		}

		
		/*
		 * INIT PEER CONNECTION
		 */
		 
		private function initPeerConnection():void
		{
			mGame = new Game();
			addChild(mGame.display());
			
			//*
			mPeerConnection = PeerConnection.getInstance();
			mPeerConnection.init(SERVER_ADDRESS, DEVELOPER_KEY, mFingerprint, true);
			
			mPeerConnection.addEventListener(PeerConnectionEvent.NET_CONNECTION_CLOSED, peerConnectionNetConnectionClosedHandler);
			mPeerConnection.addEventListener(PeerConnectionEvent.NET_CONNECTION_SUCCESS, peerConnectionNetConnectionSuccessHandler);
			mPeerConnection.addEventListener(PeerConnectionEvent.RECEIVE_STREAM_CONNECTED, peerConnectionReceiveStreamConnectedHandler);
			mPeerConnection.addEventListener(PeerConnectionEvent.RECEIVED_DATA, peerConnectionReceiveDataHandler);
			
			mPeerConnection.connect();

			/*/
			mMaster = new Master(stage);
			mGame.setClient(mMaster);
			mGame.init("client");
			//*/
		}

		private function peerConnectionNetConnectionClosedHandler(e:PeerConnectionEvent):void
		{
			mGame.kill();
		}

		private function peerConnectionNetConnectionSuccessHandler(e:PeerConnectionEvent):void
		{
			SWFAddress.setValue("p2p?fpr=" + mPeerConnection.peerID());
			mGame.setConnectionURL(SWFAddress.getBaseURL() + "#" + SWFAddress.getValue());
			mGame.init("userinterface");
		}

		
		private function peerConnectionReceiveStreamConnectedHandler(e:PeerConnectionEvent):void
		{
			if(mPeerConnection.master())
			{
				mMaster = new Master(stage, mPeerConnection);
				mGame.setClient(mMaster);
			}
			else
			{
				mSlave = new Slave(stage, mPeerConnection);
				mGame.setClient(mSlave);
			}
			
			mGame.init("client");
		}

		private function peerConnectionReceiveDataHandler(e:PeerConnectionEvent):void
		{
			mReceiveObject = e.getByteArray().readObject();
			
			mGame.setData(mReceiveObject);
			mGame.update();
		}

		/*
		 * STAGE EVENTS FUNCTIONS
		 */
		 
		private function initStageEvents():void
		{
			//*
			mStats = new Stats();
			mStats.x = mStats.y = 10;
			//*/
			mStageHolder.getStage().addEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler);
		}

		private function stageKeyUpHandler(e:KeyboardEvent):void 
		{
			if(e.shiftKey && String.fromCharCode(e.keyCode) == "S") (mStats.stage) ? removeChild(mStats) : addChild(mStats);			
		}
	}
}