package de.davidochmann.games.meteornaut.assist.kongregate 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	/**
	 * @author dochmann
	 */
	 
	public class Kongregate 
	{
		private static const API_PATH:String = "http://www.kongregate.com/flash/API_AS3_Local.swf";
		private static var mInstance:Kongregate;
		
		private var mStage:Stage;
		private var mContainer:Sprite;
		private var mKongregate:Object;
		private var mLoader:Loader;
		private var mURLRequest:URLRequest;
		private var mRequestStack:Array;
		
		
		
		/*
		 * SINGLETON CONSTRUCTOR
		 */
		
		public function Kongregate(pSingletonEnforcer:SingletonEnforcer){}
		
		public static function getInstance():Kongregate
		{
			if(mInstance == null) mInstance = new Kongregate(new SingletonEnforcer());
			return mInstance;	
		}
		
		public function init(pStage:Stage, pLoad:Boolean = true):void
		{
			setStage(pStage);
			initContainer();
			initRequestStack();
			initURLRequest();
			initLoader();
			
			if(pLoad) load();
		}



		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function call():Object
		{
			return mKongregate;
		}
		
		public function stats(pName:String, pValue:Number):void
		{
			var object:Object = new Object();
			
			object.name  = pName;
			object.value = pValue;
			
			mRequestStack.push(object);
			
			runStack();
			
//			mKongregate.stats
		}

		public function container():Sprite
		{
			return mContainer;
		}

		public function load():void
		{
			mLoader.load(mURLRequest);
		}

		public function loader():Loader
		{
			return mLoader;		
		}
		

		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getStage():Stage
		{
			return mStage;
		}
		
		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}



		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initContainer():void
		{
			mContainer = new Sprite();
			mContainer.visible = false;
			
			mStage.addChild(mContainer);
		}


		private function initRequestStack():void
		{
			mRequestStack = new Array();
		}
		
		private function runStack():void
		{
			mRequestStack.reverse();
			
			var stackLength:uint = mRequestStack.length;
			var object:Object;
			
			for(var i:int = stackLength - 1; i >= 0; --i)
			{
				object = mRequestStack[i];
				mKongregate.stats.submit(object.name, object.value);
				
				object = null;
				mRequestStack.splice(i, 1);	
			}	
		}


		private function initURLRequest():void
		{
			var paramObj:Object = LoaderInfo(mStage.loaderInfo).parameters;
						
			var apiPath:String = paramObj.kongregate_api_path || API_PATH;
			Security.allowDomain(apiPath);
					
			mURLRequest = new URLRequest(apiPath);
		}
		
		private function initLoader():void
		{
			mLoader = new Loader();
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			mContainer.addChild(mLoader);
		}

		private function loaderCompleteHandler(e:Event):void 
		{
		    mKongregate = e.target.content;
		    mKongregate.services.connect();
		    runStack();
		}
	}
}

class SingletonEnforcer{}