package de.davidochmann.utilities.frametimer 
{
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * @author dochmann
	 */

	public class FrameTimer extends EventDispatcher
	{
		private var mTime:uint;
		private var mFramerate:uint;
		
		private var mTickerStartValue:int;
		private var mTicker:int;
		private var mStopped:Boolean;
		
		
		
		public function FrameTimer(pFramerate:uint, pTime:uint):void
		{
			setFramerate(pFramerate);
			setTime(pTime);
			
			initStopped();
			initTicker();			
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function start():void
		{
			mStopped = false;
		}

		public function stop():void
		{
			mStopped = true;
		}

		public function get running():Boolean
		{
			return !mStopped;
		}


		public function tick():void
		{
			if(!mStopped)
			{
				mTicker--;
				
				if(mTicker <= 0)
				{
					dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					reset();
				}
			}
		}
		
		public function reset():void
		{
			mTicker = mTickerStartValue;
		}

		
		
		/*
		 * GETTER FUNCTIONS
		 */
		
		public function getFramerate():uint
		{
			return mFramerate;
		}
		
		public function getTime():uint
		{
			return mTime;
		}
		
		/*
		 * SETTER FUNCTIONS
		 */
		
		public function setFramerate(pFramerate:uint):void
		{
			mFramerate = pFramerate;
		}
		 
		public function setTime(pTime:uint):void
		{
			mTime = pTime;
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function initStopped():void
		{
			mStopped = true;
		}
		 
		private function initTicker():void
		{
			mTickerStartValue = mTime * .001 * mFramerate;
			mTicker = mTickerStartValue;
		}
	}
}
