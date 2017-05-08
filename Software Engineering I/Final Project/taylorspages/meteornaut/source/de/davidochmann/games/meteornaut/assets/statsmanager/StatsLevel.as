package de.davidochmann.games.meteornaut.assets.statsmanager 
{
	/**
	 * @author dochmann
	 */
	public class StatsLevel 
	{
		public var mID:uint;
		public var mScore:uint;
		public var mCombo:uint;
		public var mTime:uint;
		public var mComplete:Boolean;
		


		public function StatsLevel(){}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */

		public function getID():uint
		{
			return mID;
		}

		public function getScore():uint
		{
			return mScore;
		}
		
		public function getCombo():uint
		{
			return mCombo;
		}

		public function getTime():uint
		{
			return mTime;	
		}

		public function getComplete():Boolean
		{
			return mComplete;
		}

		/*
		 * SETTER FUNCTIONS
		 */

		public function setID(pID:uint):void
		{
			mID = pID;
		}

		public function setScore(pScore:uint):void
		{
			mScore = pScore;
		}
		
		public function setCombo(pCombo:uint):void
		{
			mCombo = pCombo;
		}

		public function setTime(pTime:uint):void
		{
			mTime = pTime;
		}

		public function setComplete(pComplete:Boolean):void
		{
			mComplete = pComplete;
		}
	}
}
