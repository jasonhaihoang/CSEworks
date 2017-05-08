package de.davidochmann.games.meteornaut.assets.explosionmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.graphics.embed.RockAnimationExplosion;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import flash.display.Sprite;

	/**
	 * @author dochmann
	 */

	public class ExplosionManager extends AbstractAsset 
	{
		private var mGameEmbed:GameEmbed;
		private var mClientLayer:Sprite;
		
		
		
		public function ExplosionManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		override public function init():void
		{
			register(Notification.SCREENLEVEL_GAMEEMBED);
			register(Notification.TO_EXPLOSION_MANAGER_ROCKEXPLOSION);
			register(Notification.ANIMATIONMANAGER_ANIMATION_END);
		}
		
		override public function kill():void
		{
			unregister(Notification.SCREENLEVEL_GAMEEMBED);
			unregister(Notification.TO_EXPLOSION_MANAGER_ROCKEXPLOSION);
			unregister(Notification.ANIMATIONMANAGER_ANIMATION_END);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.SCREENLEVEL_GAMEEMBED:
					mGameEmbed	 = args[0] as GameEmbed;
					mClientLayer = mGameEmbed.mClientLayer;
					break;
					
				case Notification.TO_EXPLOSION_MANAGER_ROCKEXPLOSION:
					addRockExplosion(args[0] as Number, args[1] as Number, args[2] as Number, args[3] as Number);
					break;
					
				case Notification.ANIMATIONMANAGER_ANIMATION_END:
					if(args[1] == AnimationID.ROCK_EXPLOSION) removeRockExplosion(args[0] as RockAnimationExplosion);
					break;	
			}
		}
		
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		 
		private function addRockExplosion(pX:int, pY:int, pScale:Number, pRotation:Number):void
		{	
			var rockExplosion:RockAnimationExplosion = new RockAnimationExplosion();
			
			rockExplosion.x = pX;
			rockExplosion.y = pY;
			rockExplosion.rotation = pRotation;			
			rockExplosion.scaleX = rockExplosion.scaleY = pScale;
			
			mClientLayer.addChild(rockExplosion);
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_ANIMATION, AnimationID.ROCK_EXPLOSION, rockExplosion);
			notify(Notification.TO_ANIMATIONMANAGER_PLAY_ANIMATION, rockExplosion);		
		}
		
		private function removeRockExplosion(pRockAnimationExplosion:RockAnimationExplosion):void
		{
			mClientLayer.removeChild(pRockAnimationExplosion);
			notify(Notification.TO_ANIMAITONMANAGER_REMOVE_ANIMATION, pRockAnimationExplosion);
			pRockAnimationExplosion = null;			
		}
	}
}