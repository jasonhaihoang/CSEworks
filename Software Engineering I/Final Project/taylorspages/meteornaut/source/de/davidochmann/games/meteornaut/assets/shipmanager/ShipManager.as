package de.davidochmann.games.meteornaut.assets.shipmanager
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundID;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.extended.Ship;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author dochmann
	 */
	public class ShipManager extends AbstractAsset 
	{
		private var mGameEmbed:GameEmbed;
		private var mShip:Ship;
		private var mShipScore:TextField;
		private var mShipMultiplier:TextField;
		private var mStage:Stage;
		private var mStageWidth:uint;
		private var mStageHeight:uint;
		
		private var mMoveShipDestinationX:Number;
		private var mMoveShipDestinationY:Number;
		private var mMoveShipMouseX:Number;
		private var mMoveShipMouseY:Number;
		private var mMoveShipX:Number;
		private var mMoveShipY:Number;
		private var mMoveShipSpeedX:Number;
		private var mMoveShipSpeedY:Number;
		private var mMoveShipRotation:Number;
		
		private var mUpdateScore:uint;
		private var mShipGUIScore:uint;
		private var mShipGUIText:String;
		private var mShipGUIMultiplierText:String;


		public function ShipManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.SCREENLEVEL_SETUP);
			register(Notification.TO_SHIPMANAGER_ADD_SHIP);
			register(Notification.SHIPMANAGER_SHIP_ADDED);
			register(Notification.CONTROLS_MOUSE_POSITION_UPDATE);
			register(Notification.HITMANAGER_HIT_SHIP_ROCK);
			register(Notification.GAMEPLAY_NEW_SCORE);
			register(Notification.GAMEPLAY_NEW_MULTIPLIER);
			register(Notification.SCREENMANAGER_SCREENSWITCHED);
			register(Notification.ANIMATIONMANAGER_ANIMATION_END);
		}
		
		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENLEVEL_GAMEEMBED);
			unregister(Notification.SCREENLEVEL_SETUP);
			unregister(Notification.TO_SHIPMANAGER_ADD_SHIP);
			unregister(Notification.SHIPMANAGER_SHIP_ADDED);
			unregister(Notification.CONTROLS_MOUSE_POSITION_UPDATE);
			unregister(Notification.HITMANAGER_HIT_SHIP_ROCK);
			unregister(Notification.GAMEPLAY_NEW_SCORE);
			unregister(Notification.GAMEPLAY_NEW_MULTIPLIER);
			unregister(Notification.SCREENMANAGER_SCREENSWITCHED);
			unregister(Notification.ANIMATIONMANAGER_ANIMATION_END);
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
				
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed = args[0] as GameEmbed;
					break;
				
				case Notification.SCREENLEVEL_SETUP:
					initUpdateScore();
					initShipGUIScore();
					initShipGUIText();
					initShipMultiplierText();
					break;
				
				case Notification.TO_SHIPMANAGER_ADD_SHIP:
					addShip(args[0] as Number, args[1] as Number);
					break;
					
				case Notification.CONTROLS_MOUSE_POSITION_UPDATE:
					moveShip(args[0] as Number, args[1] as Number, args[2] as Boolean);
					updateShipGUI();
					break;
					
				case Notification.GAMEPLAY_NEW_SCORE:
					updateScore(args[0] as Number);
					updateMultiplier(0, 0);
					break;
				
				case Notification.GAMEPLAY_NEW_MULTIPLIER:
					updateMultiplier(args[0] as uint, args[1] as uint);
					break;
				
				case Notification.HITMANAGER_HIT_SHIP_ROCK:
					mShip.mBody.visible = false;
					mShip.mAnimationExplosion.rotation = mShip.mBody.rotation;
					
					if(!mShip.mHit)
					{
						notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, mShip.mAnimationExplosion);
						notify(Notification.TO_SOUNDMANAGER_PLAYSOUND, SoundID.GAMEOVER);
					}

					mShip.mHit = true;
					break;
					
				case Notification.ANIMATIONMANAGER_ANIMATION_END:
					if(args[0].parent is Ship && args[1] == AnimationID.SHIP_EXPLOSION)	
					{
						notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_GAMEOVER);
						notify(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION, mShip.mAnimationExplosion);
					}
					break;
			}
		}
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initUpdateScore():void
		{
			mUpdateScore = 0;
		}
		
		private function initShipGUIScore():void
		{
			mShipGUIScore = 0;
		}

		private function initShipGUIText():void
		{
			mShipGUIText = "";
		}

		private function initShipMultiplierText():void
		{
			mShipGUIMultiplierText = ""; 
		}


		private function addShip(pX:Number, pY:Number):void
		{
			mShip = new Ship();
			
			mShip.buttonMode   = false;
			mShip.mouseEnabled = false;

			mShip.x = pX;
			mShip.y = pY;
			
			mGameEmbed.mClientLayer.addChild(mShip);

			mShipScore		= mShip.mInterface.mScore;
			mShipMultiplier = mShip.mInterface.mMuliplier;
			
			mShipScore.autoSize		 = TextFieldAutoSize.LEFT;
			mShipMultiplier.autoSize = TextFieldAutoSize.RIGHT;


			var textFormat:TextFormat = new TextFormat("VerdanaRegular");
			
			mShipScore.embedFonts = true;
			mShipScore.defaultTextFormat = textFormat; 
			mShipScore.setTextFormat(textFormat);

			mShipMultiplier.embedFonts = true;			
			mShipMultiplier.defaultTextFormat = textFormat; 
			mShipMultiplier.setTextFormat(textFormat);
			
			mShipMultiplier.visible = false;

			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, AnimationID.SHIP_EXPLOSION, mShip.mAnimationExplosion, true);
			notify(Notification.SHIPMANAGER_SHIP_ADDED, mShip);
		}

		private function moveShip(pMouseX:Number, pMouseY:Number, pMouseOut:Boolean):void
		{
			mMoveShipMouseX = (pMouseX >  mStageWidth) ?  mStageWidth : (pMouseX < 0) ? 0 : pMouseX;
			mMoveShipMouseY = (pMouseY > mStageHeight) ? mStageHeight : (pMouseY < 0) ? 0 : pMouseY;
			
			mMoveShipDestinationX = mMoveShipMouseX - mShip.x;
			mMoveShipDestinationY = mMoveShipMouseY - mShip.y;
			
			if(!pMouseOut)
			{
				mMoveShipSpeedX = mMoveShipDestinationX * .06;
				mMoveShipSpeedY = mMoveShipDestinationY * .06;
				
				if(mMoveShipDestinationX != 0 && mMoveShipDestinationY != 0)
					mMoveShipRotation = Math.atan2(mMoveShipDestinationY, mMoveShipDestinationX) * (180 / Math.PI);
			}

			mMoveShipX = mShip.x + mMoveShipSpeedX; 
			mMoveShipY = mShip.y + mMoveShipSpeedY;
			
			(mMoveShipX < -mShip.width  *.5) ? mMoveShipX = mStageWidth + mShip.width	*.5 : (mMoveShipX > mStageWidth  + mShip.width *.5)  ? mMoveShipX = -mShip.width  *.5 : mMoveShipX;
			(mMoveShipY < -mShip.height *.5) ? mMoveShipY = mStageHeight + mShip.height *.5 : (mMoveShipY > mStageHeight + mShip.height *.5) ? mMoveShipY = -mShip.height *.5 : mMoveShipY;

			mShip.x = mMoveShipX; 
			mShip.y = mMoveShipY;
					
			mShip.mBody.rotation = mMoveShipRotation;
		}
		
		private function updateScore(pScore:uint):void
		{
			mUpdateScore = pScore;
		}
		
		private function updateShipGUI():void
		{
			mShipGUIScore = Number(mShipScore.text);
			
			if(mShipGUIScore != mUpdateScore)
			{
				mShipGUIScore += 10;
				mShipGUIText = String(mShipGUIScore);
				
				mShipGUIText = (mShipGUIText.length < 3) ? ("000" + mShipGUIText).slice(-3) : mShipGUIText;
				
				mShipScore.text = mShipGUIText;
			}
		}
		
		private function updateMultiplier(pMultiplier:uint, pScorePending:uint):void
		{			
			mShipMultiplier.visible = (pMultiplier == 0) ? false : true;
			mShipMultiplier.x = mShipScore.x + mShipScore.width - mShipMultiplier.width;
			
			mShipGUIMultiplierText = String(pScorePending) + "x" + String(pMultiplier);
			mShipMultiplier.text = mShipGUIMultiplierText;		
		}
	}
}
