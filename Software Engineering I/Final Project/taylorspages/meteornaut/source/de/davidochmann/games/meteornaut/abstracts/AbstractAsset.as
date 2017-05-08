package de.davidochmann.games.meteornaut.abstracts 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	/**
	 * @author dochmann
	 */

	public class AbstractAsset 
	{
		protected var mID:String;
		protected var mParent:AbstractAsset;
		protected var mDebug:Boolean;
		
		protected var mAssetLibrary:Dictionary;
		protected var mAssetList:Vector.<AbstractAsset>;
		protected var mNotificationLibrary:Dictionary;
		
		private var mNotifyI:uint;
		private var mNotifyAssetList:Vector.<AbstractAsset>;
		private var mNotifyAssetListParent:Vector.<AbstractAsset>;
		private var mNotifyAssetParams:Array;
		private var mNotifyAsset:AbstractAsset;
		private var mNotifyAssetNotificationLibrary:Dictionary;
		private var mNotifyAssetListLength:uint;
			
		
		
		public function AbstractAsset(pID:String, pParent:AbstractAsset)
		{
			setID(pID);
			setParent(pParent);
			
			initParentRegistration();
			initAssetLibrary();
			initAssetList();
			initNotificationLibrary();
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getID():String
		{
			return mID;
		}

		public function getParent():AbstractAsset
		{
			return mParent;
		}

		public function getDebug():Boolean
		{
			return mDebug;
		}

		/*
		 * SETTER FUNCTIONS
		 */

		public function setID(pID:String):void
		{
			mID = pID;
		}
		
		public function setParent(pParent:AbstractAsset):void
		{
			mParent = pParent;
		}

		public function setDebug(pDebug:Boolean):void
		{
			mDebug = pDebug;
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			throw new IllegalOperationError("Abstract mehthod: must be overriden in a subclass");
		}
		
		public function kill():void
		{
			throw new IllegalOperationError("Abstract mehthod: must be overriden in a subclass");
		}
			
		public function update():void
		{
			throw new IllegalOperationError("Abstract mehthod: must be overriden in a subclass");
		}

		public function call(pStatus:String, ...args:Array):void
		{
			throw new IllegalOperationError("Abstract mehthod: must be overriden in a subclass");
		}
		
		public function notify(pStatus:String, ...args:Array):void
		{	
			mNotifyAssetList = mAssetList.concat();

			if(mParent != null) 
			{
				mNotifyAssetList.unshift(mParent);
				mNotifyAssetListParent = mParent.receiveAssetList();
				mNotifyAssetList = mNotifyAssetList.concat(mNotifyAssetListParent);
			}
			
			mNotifyAssetListLength = mNotifyAssetList.length;

			for(mNotifyI = 0; mNotifyI < mNotifyAssetListLength; ++mNotifyI)
			{	
				mNotifyAsset = mNotifyAssetList[mNotifyI];
				mNotifyAssetNotificationLibrary = mNotifyAsset.receiveNotificationLibrary();
							
				if(mNotifyAssetNotificationLibrary[pStatus] as Boolean)
				{	
					mNotifyAssetParams = [pStatus];
					mNotifyAssetParams = mNotifyAssetParams.concat(args);
					mNotifyAsset.call.apply(mNotifyAsset, mNotifyAssetParams);
				
					if(mDebug) trace(pStatus, mNotifyAsset, args);
				}
			}
		}
		
		public function register(pStatus:String):void
		{
			mNotificationLibrary[pStatus] = true;
		}

		public function unregister(pStatus:String):void
		{
			if(mNotificationLibrary[pStatus] as Boolean) delete mNotificationLibrary[pStatus];
		}

		public function receiveNotificationLibrary():Dictionary
		{
			return mNotificationLibrary;
		}

		public function receiveNotificationList():Vector.<String>
		{
			var list:Vector.<String> = new Vector.<String>();
			
			var key:Object;
			for(key in mNotificationLibrary) list.push(key);
			
			return list;
		}

		public function receiveAssetList():Vector.<AbstractAsset>
		{
			return mAssetList;
		}


		public function addAsset(pAbstractAsset:AbstractAsset):void
		{
			mAssetLibrary[pAbstractAsset.getID()] = pAbstractAsset;
			mAssetList.push(pAbstractAsset);
		}

		public function removeAsset(pAbstractAsset:AbstractAsset):void
		{
			var key:Object;
			for(key in mAssetLibrary) if(mAssetLibrary[key] == pAbstractAsset){ delete mAssetLibrary[key]; break; }
			
			
			var asset:AbstractAsset;
			var assetListLength:uint = mAssetList.length;
			
			for(var i:uint = 0; i < assetListLength; ++i)
			{ 
				asset = (mAssetList[i] as AbstractAsset);
				if(pAbstractAsset == asset) { mAssetList.splice(i, 1); break; }
			} 
		}

		
				
		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initParentRegistration():void
		{
			if(mParent != null) mParent.addAsset(this);
		}

		private function initNotificationLibrary():void
		{
			mNotificationLibrary = new Dictionary();
		}

		private function initAssetLibrary():void 
		{
			mAssetLibrary = new Dictionary();
		}
		
		private function initAssetList():void
		{
			mAssetList = new Vector.<AbstractAsset>();
		}
	}
}
