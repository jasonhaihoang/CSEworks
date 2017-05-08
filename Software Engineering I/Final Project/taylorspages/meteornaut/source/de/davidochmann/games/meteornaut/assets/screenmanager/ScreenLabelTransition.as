package de.davidochmann.games.meteornaut.assets.screenmanager 
{
	import de.davidochmann.utilities.labelanimation.LabelAnimation;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	/**
	 * @author dochmann
	 */
	
	public class ScreenLabelTransition extends LabelAnimation 
	{
		private var mSwapIndex:uint;
		private var mCallbackSwap:Function;
		private var mCallbackEnd:Function;
		
		
		
		public function ScreenLabelTransition(pMovieClip:MovieClip, 
											  pSwapIndex:uint, 
											  pCallbackSwap:Function,
											  pCallbackEnd:Function,
											  pID:String = null)
		{
			setSwapIndex(pSwapIndex);
			setCallbackSwap(pCallbackSwap);
			setCallbackEnd(pCallbackEnd);

			super(pMovieClip, pID);
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getSwapIndex():uint
		{
			return mSwapIndex;
		}
		
		public function getCallbackSwap():Function
		{
			return mCallbackSwap;
		}
		
		public function getCallbackEnd():Function
		{
			return mCallbackEnd;
		}

		/*
		 * SETTER FUNCTIONS
		 */
		
		public function setSwapIndex(pSwapIndex:uint):void
		{
			mSwapIndex = pSwapIndex;
		}

		public function setCallbackSwap(pCallbackSwap:Function):void
		{
			mCallbackSwap = pCallbackSwap;
		}

		public function setCallbackEnd(pCallbackEnd:Function):void
		{
			mCallbackEnd = pCallbackEnd;
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function init():void
		{
			mLabelList = mMovieClip.currentLabels;
			
			var frameLabel:FrameLabel;
			var frame:uint;
			var name:String;
			
			var method:Function;
		
			
			frame	   = 0;
			
			mMovieClip.addFrameScript(frame, mMovieClip.stop());
			
			
			frameLabel = mLabelList[mSwapIndex];
			frame	   = frameLabel.frame - 1;
			name  	   = frameLabel.name;
			
			mMovieClip.addFrameScript(frame, mCallbackSwap);
		
			
			frame	   = mMovieClip.totalFrames - 1;	
		
			mMovieClip.addFrameScript(frame, mCallbackEnd);		
		}
	}
}
