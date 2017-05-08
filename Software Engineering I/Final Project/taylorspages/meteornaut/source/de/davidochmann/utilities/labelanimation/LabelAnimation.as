package de.davidochmann.utilities.labelanimation
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	/**
	 * @author dochmann
	 */

	public class LabelAnimation 
	{		
		protected var mMovieClip:MovieClip;
		protected var mID:String;
		
		protected var mPlayToLabel:String;
		protected var mLabelList:Array;
		protected var mLabelIndex:uint;
		
		
		
		public function LabelAnimation(pMovieClip:MovieClip, pID:String = null):void
		{			
			setMovieClip(pMovieClip);
			setID(pID);

			if(pMovieClip != null) init();
		}



		/*
		 * GETTER FUNCTIONS
		 */
		
		public function getMovieClip():MovieClip
		{
			return mMovieClip;
		}
		
		public function getID():String
		{
			return mID;
		}

		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setMovieClip(pMovieClip:MovieClip):void
		{
			mMovieClip = pMovieClip;
		}

		public function setID(pID:String):void
		{
			mID = pID;
		}

		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{
			mLabelList = mMovieClip.currentLabels;
			var labelListLength:uint = mLabelList.length;
			
			var frameLabel:FrameLabel;
			var frame:uint;
			var name:String;
			
			var method:Function;
			
			for(var i:uint = 0; i < labelListLength; ++i)
			{
				frameLabel = mLabelList[i];
				frame	   = frameLabel.frame - 1;
				name  	   = frameLabel.name;
				
				method = function():void{ checkLabel(); };
				
				mMovieClip.addFrameScript(frame, method);
			}
		}
		
		public function checkLabel():void
		{
			if(mPlayToLabel == mMovieClip.currentLabel) mMovieClip.stop();
		}
		
		/*
		 * CONTROLS
		 */

		public function jumpToLabelIndex(pIndex:uint):void
		{
			var frame:uint = (mLabelList[pIndex] as FrameLabel).frame;
			mLabelIndex = pIndex;			
			mMovieClip.gotoAndStop(frame);
		}
		
		public function playToLabelIndex(pIndex:uint):void
		{
			mPlayToLabel = (mLabelList[pIndex] as FrameLabel).name;
			mLabelIndex = pIndex;
			mMovieClip.play();
		}

		public function playToLabel(pLabel:String):void
		{
			for(var i:uint = 0; i < mLabelList.length; ++i) if(pLabel == (mLabelList[i] as FrameLabel).name){ mLabelIndex = i; break; }

			mPlayToLabel = pLabel;
			mMovieClip.play();
		}

		/*
		 * ATTRIBUTES
		 */
		
		public function labelListLength():uint
		{
			return mLabelList.length;
		}
		
		public function labelIndex():uint
		{
			return mLabelIndex;
		}
	}
}
