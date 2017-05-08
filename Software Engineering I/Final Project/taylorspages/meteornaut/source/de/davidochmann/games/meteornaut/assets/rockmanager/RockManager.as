package de.davidochmann.games.meteornaut.assets.rockmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.extended.Rock;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.utilities.calculator.Calculator;

	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * @author dochmann
	 */

	public class RockManager extends AbstractAsset 
	{
		private var mGameEmbed:GameEmbed;
		private var mClientLayer:Sprite;
		
		private var mI:int;
		private var mRockLibrary:Vector.<Rock>;
		private var mRockLibraryLength:uint;
		
		private var mStage:Stage;
		private var mStageWidth:uint;
		private var mStageHeight:uint;
		
		private var mRock:Rock;
		private var mRockX:Number;
		private var mRockY:Number;
		private var mRockChildIndex:uint;
		private var mRockRotation:Number;
		
//		private var mRock:Rock;
		
		
		
		public function RockManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{			
			register(Notification.GAME_SETUP);
			register(Notification.TO_ROCKMANAGER_ADD_ROCK);
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.FRAMEHANDLER_ENTERFRAME);
			register(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			register(Notification.ANIMATIONMANAGER_ANIMATION_END);
//			register(Notification.GAMEPLAY_COMBO_BROKEN);
			register(Notification.SCREENLEVEL_SETUP);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.TO_ROCKMANAGER_ADD_ROCK);
			unregister(Notification.SCREENLEVEL_GAMEEMBED);
			unregister(Notification.FRAMEHANDLER_ENTERFRAME);
			unregister(Notification.HITMANAGER_HIT_MISSLE_ROCK);
			unregister(Notification.ANIMATIONMANAGER_ANIMATION_END);
//			unregister(Notification.GAMEPLAY_COMBO_BROKEN);
			unregister(Notification.SCREENLEVEL_SETUP);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					mStage		 = args[0] as Stage;
					mStageWidth	 = mStage.stageWidth;
					mStageHeight = mStage.stageHeight;
					break;
			
				case Notification.TO_ROCKMANAGER_ADD_ROCK:
					addRock(args[0] as Number, args[1] as Number, args[2] as Number, args[3] as Number, args[4] as Number, args[5] as Number);
					break;
			
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed = args[0] as GameEmbed;
					mClientLayer = mGameEmbed.mClientLayer;					
					break;
				
				case Notification.SCREENLEVEL_SETUP:
					initRockLibrary();
					notify(Notification.ROCKMANAGER_NEW_ROCKLIBRARY, mRockLibrary);
					break;
				
				case Notification.FRAMEHANDLER_ENTERFRAME:
					moveRocks();
					break;
					
				case Notification.HITMANAGER_HIT_MISSLE_ROCK:
					mI = args[1] as uint;
					mRock = mRockLibrary[mI];
					
					spliceRock(mRock);
					removeRockIndex(mI);
//					selectRocks(rock.scaleX);
//					rock.mAnimationExplosion.rotation = rock.mBody.rotation;
					
//					notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, rock.mAnimationExplosion);
					break;

				case Notification.ANIMATIONMANAGER_ANIMATION_END:
					if(mRockLibraryLength == 0 && args[1] as String == AnimationID.ROCK_EXPLOSION)
						notify(Notification.ROCKMANAGER_GAME_OVER);
					break;
							
//				case Notification.GAMEPLAY_COMBO_BROKEN:
//					unselectRocks();
//					break;
			}
		}
	
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initRockLibrary():void
		{
			mRockLibrary = new Vector.<Rock>();
		}

		private function moveRocks():void
		{
			mRockLibraryLength = mRockLibrary.length;
			
			for(mI = 0; mI < mRockLibraryLength; ++mI)
			{
				mRock = mRockLibrary[mI];
				
				if(mRock.mHit) continue;
				
				mRock.mCooldown = (mRock.mCooldown < 1) ? 0 : mRock.mCooldown -1;
				
				mRockX		  = mRock.x + mRock.mDirX; 
				mRockY		  = mRock.y + mRock.mDirY; 
				mRockRotation = mRock.rotation + mRock.mDirRotation;
				
				(mRockX < -mRock.width  *.5) ? mRockX = mStageWidth  + mRock.width  *.5 : (mRockX > mStageWidth  + mRock.width *.5)  ? mRockX = -mRock.width *.5  : mRockX;
				(mRockY < -mRock.height *.5) ? mRockY = mStageHeight + mRock.height *.5 : (mRockY > mStageHeight + mRock.height *.5) ? mRockY = -mRock.height *.5 : mRockY;
				
				mRock.x = mRockX;
				mRock.y = mRockY;
				
				mRock.rotation = mRockRotation;								 					
			}
		}
		
		private function addRock(pX:Number, pY:Number, pDirection:Number, pScale:Number, pSpeed:Number = 1, pRandom:Number = 0, pIndex:int = 0):void
		{
			var rock:Rock	 = new Rock();
			
			var range:Number = 5;
			var speed:Number = 1 + range - pScale * range;			
			
			var randomDirection:Number = (Math.random() * pRandom - Math.random() * pRandom);
			
			var positionX:Number = Calculator.rotationToPositionX(pDirection + randomDirection);			var positionY:Number = Calculator.rotationToPositionY(pDirection + randomDirection);

			rock.buttonMode	    = false;
			rock.mouseChildren  = false;
			rock.mouseEnabled   = false;
			rock.rotation		= Math.random() * 360;
			rock.x		 	    = pX;
			rock.y			    = pY;
			rock.scaleX  		= pScale;
			rock.scaleY			= pScale;
			rock.mSpeed			= pSpeed;
			rock.mCooldown	    = 5;
			rock.mDirection		= pDirection;
			rock.mDirX		    = positionX * speed * pSpeed;
			rock.mDirY		    = positionY * speed * pSpeed;
			rock.mDirRotation   = Math.random() * 2 - Math.random() * 2;
			rock.hitArea	    = rock.mBody;
			
			rock.mBody.gotoAndStop(Math.ceil(Math.random() * rock.mBody.totalFrames));
			
			mRockLibrary.push(rock);
			mRockLibraryLength = mRockLibrary.length;

			if(pIndex == 0) mClientLayer.addChild(rock);
			else mClientLayer.addChildAt(rock, pIndex);
			
			
			notify(Notification.ROCKMANAGER_NEW_ROCKCOUNTER, mRockLibraryLength);
			notify(Notification.ROCKMANAGER_NEW_ROCKLIBRARY, mRockLibrary);
			
//			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, "explosion", rock.mAnimationExplosion, false);
//			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, "selected", rock.mAnimationSelected, false);
//			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, "unselected", rock.mAnimationUnselected, true);
						
		}
		
//		private function removeRock(pRock:Rock):void
//		{
//			mRockLibraryLength = mRockLibrary.length;
//			
//			for(mI = mRockLibraryLength - 1; mI >= 0; --mI)
//			{
//				mRock = mRockLibrary[mI];
//				
//				if(pRock == mRock)
//				{
//					mRockLibrary.splice(mI, 1);
//					mClientLayer.removeChild(mRock);
//					mRock = null;
//					
//					notify(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION, pRock.mAnimationExplosion);
//					
//					mRockCounter --;
//					notify(Notification.ROCKMANAGER_NEW_ROCKCOUNTER, mRockCounter);
//					
//					if(mRockCounter <= 0) notify(Notification.ROCKMANAGER_GAME_OVER);
//				}
//			}		
//		}
		
		private function removeRockIndex(pIndex:uint):void
		{
			mRock = mRockLibrary[pIndex];

//			notify(Notification.TO_EXPLOSION_MANAGER_ROCKEXPLOSION, mRock.x, mRock.y, mRock.scaleX, mRock.rotation);
			
			mRockLibrary.splice(pIndex, 1);
			mClientLayer.removeChild(mRock);
			mRock = null;
			
			mRockLibraryLength = mRockLibrary.length;
//			notify(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION, mRock.mAnimationExplosion);
			notify(Notification.ROCKMANAGER_NEW_ROCKCOUNTER, mRockLibraryLength);
			notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.EXPLOSION);
		}
		
		private function spliceRock(pRock:Rock):void
		{
			pRock.mHit		    = true;
			pRock.mDirRotation  = 0;
			pRock.mBody.visible = false;
			
			mRockChildIndex = mClientLayer.getChildIndex(pRock);
		
			if(Number(pRock.scaleX.toFixed(1)) > .1)
			{
				addRock(pRock.x, pRock.y, pRock.mDirection, pRock.scaleX - .1, pRock.mSpeed, 90, mRockChildIndex);
				addRock(pRock.x, pRock.y, pRock.mDirection, pRock.scaleX - .1, pRock.mSpeed, 90, mRockChildIndex);					  
			}
		}
		
//		private function selectRocks(pScaleX:Number):void
//		{
//			for each(mRock in mRockLibrary)
//			{	
//				if(!mRock.mHit && Math.floor(mRock.scaleX * 10) == Math.floor(pScaleX * 10))
//					notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, mRock.mAnimationSelected);
//				else
//				{
//					if(mRock.mAnimationSelected.visible)
//						notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, mRock.mAnimationUnselected);
//					
//					notify(Notification.TO_ANIMAITONMANAGER_RESET_ANIMATION, mRock.mAnimationSelected);
//				}
//			}
//		}
//		
//		private function unselectRocks():void
//		{
//			for each(mRock in mRockLibrary)
//			{
//				
//				if(mRock.mAnimationSelected.visible)
//					notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, mRock.mAnimationUnselected);
//
//				notify(Notification.TO_ANIMAITONMANAGER_RESET_ANIMATION, mRock.mAnimationSelected);				
//			}
//		}
	}
}