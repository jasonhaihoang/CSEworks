package de.davidochmann.games.meteornaut.assets.statsmanager 
{
	import flash.utils.Dictionary;
	
	/**
	 * @author dochmann
	 */
	 
	public class Stats 
	{
		public var mLevelLibrary:Dictionary;
		
		public var mVolume:Number;
		
		public var mCompleteScore:uint;
		public var mCompleteCombos:uint;
		public var mCompleteTime:uint;
		
		
		
		public function Stats():void
		{			
			initLevelLibrary();		
		}



		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getVolume():Number
		{
			return mVolume;
		}

		/*
		 * SETTER FUNCTIONS
		 */
				
		public function setVolume(pVolume:Number):void
		{
			mVolume = pVolume;
		}


		
		/*
		 * PUBLIC FUNCTIONS
		 */

		public function completeScore():uint
		{
			return mCompleteScore;
		}

		public function completeCombos():uint
		{
			return mCompleteCombos;
		}

		public function completeTime():uint
		{
			return mCompleteTime;
		}

		public function calculateCompleteValues():void 
		{
			mCompleteScore = mCompleteCombos = mCompleteTime = 0;
			
			var statsLevel:StatsLevel;
			
			for each(statsLevel in mLevelLibrary)
			{
				mCompleteScore	+= statsLevel.getScore();
				mCompleteCombos += statsLevel.getCombo();
				mCompleteTime	+= statsLevel.getTime();	
			}
		}

		public function getLevelID(pID:uint):StatsLevel
		{
			return mLevelLibrary[pID] as StatsLevel;
		}

		public function setLevelID(pID:uint, pLevel:StatsLevel):void
		{
			mLevelLibrary[pID] = pLevel;
		}


		
		/*
		 * PRIVATE FUNCTIONS
		 */
 
		private function initLevelLibrary():void
		{
			mLevelLibrary = new Dictionary();
		}
	}
}