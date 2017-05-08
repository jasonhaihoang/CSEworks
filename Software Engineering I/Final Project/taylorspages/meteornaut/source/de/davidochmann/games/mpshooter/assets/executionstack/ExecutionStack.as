package de.davidochmann.games.mpshooter.assets.executionstack 
{
	import de.davidochmann.games.mpshooter.interfaces.IAsset;

	/**
	 * @author dochmann
	 */

	public class ExecutionStack implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
	
		public var mExecutionList:Vector.<IAsset>;
		
		
		
		public function ExecutionStack():void
		{
			initExecutionList();	
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			var executionListLength:uint = mExecutionList.length;
			var asset:IAsset;

			for(var i:uint = 0; i < executionListLength; ++i)
			{
				asset = IAsset(mExecutionList[i]);
				asset.setData(mData);
				asset.init();
			}
		}
		
		public function kill():void{}
		
		public function update():void
		{
			var executionListLength:uint = mExecutionList.length;
			var data:Object = IAsset(mExecutionList[0]).getData();

			var asset:IAsset;

			for(var i:uint = 0; i < executionListLength; ++i)
			{
				asset = IAsset(mExecutionList[i]);

				asset.setData(data);
				asset.update();	

				data = asset.getData();
			}
			
			mData = data;
		}

		public function updateData():void
		{
			var executionListLength:uint = mExecutionList.length;
			var asset:IAsset;

			for(var i:uint = 0; i < executionListLength; ++i)
			{
				asset = IAsset(mExecutionList[i]);
				asset.setData(mData);
			}
		}

		public function addAsset(pAsset:IAsset):void
		{
			mExecutionList.push(pAsset);
		}

		public function removeAsset(pAsset:IAsset):void
		{
			var executionListLength:uint = mExecutionList.length;
			var asset:IAsset;
			
			for(var i:uint = 0; i < executionListLength; ++i)
			{
				asset = IAsset(mExecutionList[i]);
				
				if(pAsset == asset) 
				{
					mExecutionList.splice(i, 1);
					break; 
				}
			}
		}

		public function removeID(pID:String):void
		{
			var executionListLength:uint = mExecutionList.length;
			var asset:IAsset;
			var id:String;
			
			for(var i:uint = 0; i < executionListLength; ++i)
			{
				asset = IAsset(mExecutionList[i]);
				id 	  = asset.getID();
				
				if(pID == id) 
				{
					mExecutionList.splice(i, 1);
					break; 
				}
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

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initExecutionList():void
		{
			mExecutionList = new Vector.<IAsset>();
		}
	}
}
