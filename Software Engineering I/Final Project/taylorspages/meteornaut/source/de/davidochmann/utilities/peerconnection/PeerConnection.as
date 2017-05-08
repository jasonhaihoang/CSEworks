package de.davidochmann.utilities.peerconnection 
{	
	import de.davidochmann.utilities.peerconnection.event.PeerConnectionEvent;

	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;

	/**
	 * @author David Ochmann
	 */
	 	
	public class PeerConnection extends EventDispatcher 
	{	
		private static var mInstance:PeerConnection;
		
		private const NETSTREAM_PUBLISH:String = "media";
		
		private var mNetConnection:NetConnection;
		private var mSendStream:NetStream;
		private var mReceiveStream:NetStream;

		private var mPeerID:String;
		private var mFarPeerID:String;
		private var mMaster:Boolean;
		private var mByteArrayReceive:ByteArray;
		private var mByteArraySend:ByteArray;
		
		private var mServerAddress:String;
		private var mDeveloperKey:String;
		private var mFingerprint:String;
		private var mDebug:Boolean;
		
		
			
		/*
		 * SINGLETON CONSTRUCTOR
		 */
		
		public function PeerConnection(SingletonEnforcer:SingletonEnforcer){}
		
		public static function getInstance():PeerConnection
		{
			if(mInstance == null) mInstance = new PeerConnection(new SingletonEnforcer());
			return mInstance;
		}

		public function init(pServerAddress:String = null,
							 pDeveloperKey:String  = null,
							 pFingerprint:String   = null,
							 pDebug:Boolean		   = false):void
		{
			setServerAddress(pServerAddress);
			setDeveloperKey(pDeveloperKey);
			setFingerprint(pFingerprint);
			setDebug(pDebug);
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		public function connect():void
		{
			initFingerprint();
			initNetConnection();	
		}


		public function receive(pByteArray:ByteArray):void
		{
			mByteArrayReceive = pByteArray;
			mByteArrayReceive.inflate();
			
			dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.RECEIVED_DATA, mByteArrayReceive));	
		}
		
		public function send(pByteArray:ByteArray):void
		{
			mByteArraySend = pByteArray;
			mByteArraySend.deflate();
			
			mSendStream.send("receive", mByteArraySend);
			dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.SEND_DATA, mByteArraySend));
		}

		
		public function master():Boolean
		{
			return mMaster;
		}

		public function peerID():String
		{
			return mPeerID;
		}
		
		public function farPeerID():String
		{
			return mFarPeerID;
		}

		
		public function receiveStream():NetStream
		{
			return mReceiveStream;
		}

		public function sendStream():NetStream
		{
			return mSendStream;
		}


		
		/*
		 * GETTER FUNCTIONS
		 */
		
		public function getServerAdddress():String
		{
			return mServerAddress;
		}
		 
		public function getDeveloperKey():String
		{
			return mDeveloperKey;
		}

		public function getFingerprint():String
		{
			return mFingerprint;
		}
		
		public function getDebug():Boolean
		{
			return mDebug;
		}

		
		
		/*
		 * SETTER FUNCTIONS
		 */
		
		public function setServerAddress(pServerAddress:String):void
		{
			mServerAddress = pServerAddress;
		}
		 
		public function setDeveloperKey(pDeveloperKey:String):void
		{
			mDeveloperKey = pDeveloperKey;
		}

		public function setFingerprint(pFingerprint:String):void
		{
			mFingerprint = pFingerprint;
		}

		public function setDebug(pDebug:Boolean):void
		{
			mDebug = pDebug;
		}

		
		
		/*
		 * INIT FINGERPRINT
		 */
		
		private function initFingerprint():void
		{
			if(mFingerprint != null && mFingerprint != "") mFarPeerID = mFingerprint;			
		}
		
		
		/*
		 * INIT NETCONNECTION
		 */
		
		private function initNetConnection():void
		{
			mNetConnection = new NetConnection();
			mNetConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionNetStatusHandler);
			mNetConnection.connect(mServerAddress + mDeveloperKey);
		}		

		private function netConnectionNetStatusHandler(e:NetStatusEvent):void
		{
			if(mDebug) trace(e.info.code);
			
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					initPeerID();
					initSendStream();
					initReceiveStream();
					initHost();
					
					dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.NET_CONNECTION_SUCCESS));					
					break;
					
				case "NetStream.Connect.Closed":
					dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.NET_CONNECTION_CLOSED));
					break;
			}
		}

		private function initPeerID():void
		{
			mPeerID = mNetConnection.nearID;
		}


		/*
		 * INIT SEND STREAM
		 */
		
		private function initSendStream():void
		{
			mSendStream = new NetStream(mNetConnection, NetStream.DIRECT_CONNECTIONS);
			
			mSendStream.addEventListener(NetStatusEvent.NET_STATUS, sendStreamNetStatusHandler);
			mSendStream.publish(NETSTREAM_PUBLISH);

			var mSendStreamClient:Object = new Object();
			mSendStreamClient.onPeerConnect = sendStreamOnPeerConnect;
			
			mSendStream.client = mSendStreamClient;
		}
		
		private function sendStreamOnPeerConnect(pCallerNS:NetStream):Boolean
		{
			mFarPeerID = pCallerNS.farID;				
			if(mReceiveStream == null) initReceiveStream();
			
			dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.SEND_STREAM_CONNECTED));
					
			return true;
		}
		
		private function sendStreamNetStatusHandler(e:NetStatusEvent):void
		{
			if(mDebug) trace(e.info.code);
		}
		

		/*
		 * INIT RECEIVE STREAM
		 */
		
		private function initReceiveStream():void
		{			
			if(mFarPeerID == null) return;
			
			mReceiveStream = new NetStream(mNetConnection, mFarPeerID);
			mReceiveStream.addEventListener(NetStatusEvent.NET_STATUS, receiveStreamNetStatusHandler);
			mReceiveStream.play(NETSTREAM_PUBLISH);
			
			mReceiveStream.client = this;
			
			dispatchEvent(new PeerConnectionEvent(PeerConnectionEvent.RECEIVE_STREAM_CONNECTED));
		}
		
		private function receiveStreamNetStatusHandler(e:NetStatusEvent):void
		{
			if(mDebug) trace(e.info.code);
		}

		
		/*
		 * INIT HOST
		 */
		 
		private function initHost():void
		{
			if(mReceiveStream == null) mMaster = true;	
		}
	}
}

class SingletonEnforcer{}
