package de.davidochmann.games.mpshooter.assets.sender 
{
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	import de.davidochmann.utilities.peerconnection.PeerConnection;

	import flash.utils.ByteArray;
	/**
	 * @author dochmann
	 */

	public class Sender implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
		private var mPeerConnection:PeerConnection;
		private var mByteArray:ByteArray;
		
		
		
		public function Sender(pPeerConnection:PeerConnection):void
		{
			setPeerConnection(pPeerConnection);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			initByteArray();
		}
		
		public function kill():void{}
		
		public function update():void
		{
			if(mPeerConnection != null)
			{
				mByteArray.clear();
				mByteArray.writeObject(mData);
				mPeerConnection.send(mByteArray);
			}
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

		public function setPeerConnection(pPeerConnection:PeerConnection):void
		{
			mPeerConnection = pPeerConnection;
		}
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initByteArray():void
		{
			mByteArray = new ByteArray();
		}
	}
}
