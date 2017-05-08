package de.davidochmann.games.mpshooter.assets.statemanager 
{
	import flash.utils.Dictionary;
	import de.davidochmann.games.mpshooter.interfaces.IAsset;
	
	/**
	 * @author dochmann
	 */
	
	public class StateManager implements IAsset 
	{
		private var mID:String;
		private var mData:Object;
		
		private var mDictionary:Dictionary;
		
		
		
		public function StateManager(){}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			initDictionary();
		}
		
		public function kill():void{}
		
		public function update():void{}
		
		public function callState(pName:String):void
		{
			var list:Vector.<Object> = (mDictionary[pName] as Vector.<Object>);
			var listLength:uint = list.length;
			
			var object:Object;
			var scope:Object; 	
			var method:Function;
			var args:Object;	
			
			for(var i:uint = 0; i < listLength; ++i)
			{
				object = Object(list[i]);
				scope  = Object(object.scope);
				method = (object.method as Function);	
				args   = (object.args as Object);
				
				method.apply(scope, args);
			}
		}
		
		public function addState(pScope:Object, pName:String, pFunction:Function, ...args:*):void
		{
			var list:Vector.<Object> = (mDictionary[pName] as Vector.<Object>);
			
			if(list == null)
			{
				mDictionary[pName] = new Vector.<Object>();
				list = mDictionary[pName];
			}
			
			var object:Object = new Object();
			
			object.name   = pName;
			object.scope  = pScope;	
			object.method = pFunction; 
			object.args	  = args;
			
			list.push(object);
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

		
		private function initDictionary():void
		{
			mDictionary = new Dictionary();
			
//			mDictionary["kill"] = [test];
//			addState(this, "test", test, "hallo", 1);
//			callState("test");
//			trace((mDictionary["kill"][0] as Function).call(this, "hello", 1));	
		}
	}
}
