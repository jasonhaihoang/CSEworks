package de.davidochmann.utilities.peerconnection.event 
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	/**
	 * @author David Ochmann
	 */

	public class PeerConnectionEvent extends Event 
	{
		public static var NET_CONNECTION_SUCCESS:String   = "NET_CONNECTION_SUCCESS";
		public static var NET_CONNECTION_CLOSED:String    = "NET_CONNECTION_CLOSED";
		public static var SEND_STREAM_CONNECTED:String 	  = "SEND_STREAM_PEER_CONNECTED";		public static var RECEIVE_STREAM_CONNECTED:String = "RECEIVE_STREAM_PEER_CONNECTED";
		public static var RECEIVED_DATA:String			  = "RECEIVED_DATA";
		public static var SEND_DATA:String				  = "SEND_DATA";
		
		private var mByteArray:ByteArray;
		
		
			
		public function PeerConnectionEvent(type:String,
											pByteArray:ByteArray = null,
											bubbles:Boolean = false, 
											cancelable:Boolean = false)
		{
			setByteArray(pByteArray);
			super(type, bubbles, cancelable);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function clone():Event
		{
			return new PeerConnectionEvent(type, mByteArray);
		}

		override public function toString():String
		{
			return formatToString("PeerConnectionEvent", "type", "pObject");	
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getByteArray():ByteArray
		{
			return mByteArray;
		}
		
		
		
		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setByteArray(pByteArray:ByteArray):void
		{
			mByteArray = pByteArray;
		}
	}
}
