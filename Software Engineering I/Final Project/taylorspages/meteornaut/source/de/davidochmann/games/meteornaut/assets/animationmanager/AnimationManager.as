package de.davidochmann.games.meteornaut.assets.animationmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.labelanimation.LabelAnimation;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	/**
	 * @author dochmann
	 */
	
	public class AnimationManager extends AbstractAsset 
	{
		private var mAnimationLibrary:Dictionary;
		private var mLabelAnimationLibrary:Dictionary;
		
		private var mMethod0:Function;
		private var mMethod1:Function;
		
		private var mLabelAnimation:LabelAnimation;
		
		
		
		public function AnimationManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION);
			register(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION);
			register(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION);
			register(Notification.TO_ANIMAITONMANAGER_RESET_ANIMATION);
			register(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION);
			register(Notification.TO_ANIMATIONMANAGER_REMOVE_LABELANIMATION);
			register(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX);
		}

		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION);
			unregister(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION);
			unregister(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION);
			unregister(Notification.TO_ANIMAITONMANAGER_RESET_ANIMATION);
			unregister(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION);
			unregister(Notification.TO_ANIMATIONMANAGER_REMOVE_LABELANIMATION);
			unregister(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX);
		}

		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initAnimationLibrary();
					initLabelAnimationLibrary();
					break;
				
				
				case Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION:
					addAnimation(args[0] as String, args[1] as MovieClip, args[2] as Boolean);			
					break;
								
				case Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION:
					playAnimation(args[0] as MovieClip);
					break;
				
				case Notification.TO_ANIMAITONMANAGER_RESET_ANIMATION:
					resetAnimation(args[0] as MovieClip);
					break;
				
				case Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION:
					removeAnimation(args[0] as MovieClip);
					break;
				
					
				case Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION:
					addLabelAnimation(args[0] as String, args[1] as MovieClip, args[2] as int);
					break;
				
				case Notification.TO_ANIMATIONMANAGER_REMOVE_LABELANIMATION:
					removeLabelAnimation(args[0] as MovieClip);
					break;
					
				case Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX:
					playLabelAnimationIndex(args[0] as MovieClip, args[1] as uint);
					break;
			}
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initAnimationLibrary():void 
		{
			mAnimationLibrary = new Dictionary();
		}

		private function initLabelAnimationLibrary():void
		{
			mLabelAnimationLibrary = new Dictionary();
		}

		/*
		 * ANIMATION FUNCTIONS
		 */

		private function playAnimation(pMovieClip:MovieClip):void
		{
			if(pMovieClip.visible) return;
			
			if(mAnimationLibrary[pMovieClip] != undefined)
			{				
				pMovieClip.visible = true;
				pMovieClip.gotoAndPlay(2);
			}
		}

		private function removeAnimation(pMovieClip:MovieClip):void
		{
			delete mAssetLibrary[pMovieClip];
		}

		private function resetAnimation(pMovieClip:MovieClip):void
		{
			pMovieClip.visible = false;
			pMovieClip.gotoAndStop(1);
		}


		private function addAnimation(pID:String, pMovieClip:MovieClip, pReset:Boolean):void
		{
			if(pID == null) throw new IllegalOperationError("Animation ID has to be parsed");
						
			pMovieClip.visible = false;
						
			mMethod0 = function():void{ pMovieClip.stop(); };
			mMethod1 = function():void{ animationEnd(pID, pMovieClip, pReset); };

			pMovieClip.addFrameScript(0, mMethod0);
			pMovieClip.addFrameScript(pMovieClip.totalFrames - 1, mMethod1);
			
			mAnimationLibrary[pMovieClip] = pID;	
		}
		
		private function animationEnd(pID:String, pMovieClip:MovieClip, pReset:Boolean):void
		{
			notify(Notification.ANIMATIONMANAGER_ANIMATION_END, pMovieClip, pID);
			if(pReset) resetAnimation(pMovieClip);
		}
		
		/*
		 * LABELANIMATION FUNCTIONS
		 */
		 
		private function addLabelAnimation(pID:String, pMovieClip:MovieClip, pLabelIndex:int):void
		{
			mLabelAnimation = new LabelAnimation(pMovieClip, pID);
			
			if(pLabelIndex == -1) pMovieClip.gotoAndStop(0);
			else mLabelAnimation.playToLabelIndex(pLabelIndex);
			
			mLabelAnimationLibrary[pMovieClip] = mLabelAnimation;
		}

		private function removeLabelAnimation(pMovieClip:MovieClip):void
		{
			delete mLabelAnimationLibrary[pMovieClip];
		}
		
		private function playLabelAnimationIndex(pMovieClip:MovieClip, pLabelIndex:uint):void
		{
			mLabelAnimation = mLabelAnimationLibrary[pMovieClip];
			if(mLabelAnimation != null) mLabelAnimation.playToLabelIndex(pLabelIndex);
		}
	}
}
