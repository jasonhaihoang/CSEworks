package de.davidochmann.games.meteornaut.assets.screenlevel
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.setupmanager.Setup;
	import de.davidochmann.games.meteornaut.assets.setupmanager.SetupLevel;
	import de.davidochmann.games.meteornaut.graphics.embed.GameEmbed;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * @author dochmann
	 */
	
	public class ScreenLevel extends AbstractAsset implements IDisplayHolder 
	{
		private var mGameEmbed:GameEmbed;
		private var mPauseIcon:MovieClip;
		private var mStage:Stage;
		private var mSetup:Setup;
		
		
		
		public function ScreenLevel(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}


	
		/*
		 * PUBLIC FUNCTIONS
		 */

		public function display():Sprite
		{
			return mGameEmbed;
		}

		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.SETUPMANAGER_SETUP);
			register(Notification.SCREENLEVEL_SETUP_COMPLETE);
			register(Notification.FRAMEHANDLER_GAMEPAUSED);
			register(Notification.TO_LEVELSETUP_CREATELEVEL);
		}

		override public function kill():void
		{
			clearGameEmbed();
			unregister(Notification.GAME_SETUP);
			unregister(Notification.SCREENLEVEL_SETUP_COMPLETE);
			unregister(Notification.SETUPMANAGER_SETUP);
			unregister(Notification.FRAMEHANDLER_GAMEPAUSED);
			unregister(Notification.TO_LEVELSETUP_CREATELEVEL);
		}

		override public function call(pStatus:String, ...args:Array):void
		{
			switch(pStatus)
			{
				case Notification.GAME_SETUP:
					mStage = args[0] as Stage;
					
					initGameEmbed();
					
					notify(Notification.SCREENLEVEL_GAMEEMBED, mGameEmbed);
					notify(Notification.TO_SCREENMANAGER_ADDSCREEN, ScreenID.SCREEN_GAME, this);
					break;	
				
				case Notification.SETUPMANAGER_SETUP:
					mSetup = args[0] as Setup;
					break;

				case Notification.SCREENLEVEL_SETUP_COMPLETE:
					mPauseIcon.gotoAndStop(0);
					mPauseIcon.visible = false;
					break;

				case Notification.FRAMEHANDLER_GAMEPAUSED:
					if(args[0] as Boolean)
					{
						mPauseIcon.visible = true;
						notify(Notification.TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX, mPauseIcon, 0);
					}
					else
					{
						mPauseIcon.visible = false;
						mPauseIcon.gotoAndStop(0);
					}
					break;
		
				case Notification.TO_LEVELSETUP_CREATELEVEL:
					clearGameEmbed();

					var setupLevel:SetupLevel = args[0] as SetupLevel;
					notify(Notification.SCREENLEVEL_SETUP);
					
					var ship:Object = setupLevel.ship();
					notify(Notification.TO_SHIPMANAGER_ADD_SHIP, ship.x, ship.y, ship.direction);

					var rock:Object;
					var rockList:Vector.<Object> = setupLevel.rockList();
					var rockListLength:uint = rockList.length;					
								
					for(var i:uint = 0; i < rockListLength; ++i)
					{
						rock = rockList[i] as Object;
						notify(Notification.TO_ROCKMANAGER_ADD_ROCK, rock.x, rock.y, rock.direction, rock.scale, rock.speed);	
					}
					
					notify(Notification.SCREENLEVEL_SETUP_COMPLETE, setupLevel);
					notify(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_GAME);
					break;							
			}
		}
		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initGameEmbed():void
		{
			mGameEmbed = new GameEmbed();
			
			mPauseIcon = mGameEmbed.mPauseIcon;
			mPauseIcon.visible = false;
			
			notify(Notification.TO_ANIMATIONMANAGER_ADD_LABELANIMATION, AnimationID.LABELANIMATION_GAMEPAUSE, mPauseIcon, -1);
		}

		private function clearGameEmbed():void
		{
			while(mGameEmbed.mClientLayer.numChildren > 0) mGameEmbed.mClientLayer.removeChildAt(0);					
		}
	}
}
