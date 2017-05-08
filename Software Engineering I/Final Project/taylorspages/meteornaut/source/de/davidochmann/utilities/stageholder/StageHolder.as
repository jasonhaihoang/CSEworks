package de.davidochmann.utilities.stageholder 
{
	/**
	 * @author David Ochmann
	 */
	
	import flash.display.Stage;

	public class StageHolder 
	{
		private static var mInstance:StageHolder;
		
		private var mStage:Stage;
		
		
		
		/*
		 * SINGLETON CONSTRUCTOR
		 */
		
		public function StageHolder(pSingletonEnforcer:SingletonEnforcer){}
		
		public static function getInstance():StageHolder
		{
			if(mInstance == null) mInstance = new StageHolder(new SingletonEnforcer());
			return mInstance;
		}
		
		public function init(pStage:Stage):void
		{
			setStage(pStage);
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getStage():Stage
		{
			return mStage;
		}
		
		
		
		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}
	}
}

class SingletonEnforcer{}