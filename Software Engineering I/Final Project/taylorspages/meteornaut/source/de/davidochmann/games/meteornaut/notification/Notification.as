package de.davidochmann.games.meteornaut.notification 
{
	/**
	 * @author dochmann
	 */
	 
	public class Notification 
	{
		public static const GAME_SETUP:String			   	   			        = "GAME_SETUP";
		
		public static const SCREENSTATS_STARS:String							= "SCREENSTATS_STARS";
		
		public static const SCREENLEVEL_GAMEEMBED:String		 		        = "SCREENLEVEL_GAMEEMBED";
		public static const SCREENLEVEL_LEVELLIBRARY:String				        = "SCREENLEVEL_LEVELLIBRARY";
		public static const SCREENLEVEL_SETUP:String					        = "SCREENLEVEL_SETUP";
		public static const SCREENLEVEL_SETUP_COMPLETE:String	 		        = "SCREENLEVEL_SETUP_COMPLETE";
		
		public static const FRAMEHANDLER_ENTERFRAME:String			            = "FRAMEHANDLER_ENTERFRAME";
		public static const FRAMEHANDLER_GAMEPAUSED:String						= "FRAMEHANDLER_GAMEPAUSED";
		
		public static const CONTROLS_MOUSE_POSITION_UPDATE:String 	            = "CONTROLS_MOUSE_POSITION_UPDATE";
		public static const CONTROLS_MOUSE_DOWN:String			 	            = "CONTROLS_MOUSE_DOWN";
		public static const CONTROLS_MOUSE_UP:String					        = "CONTROLS_MOUSE_UP";
		public static const CONTROLS_KEY_UP_ESCAPE:String						= "CONTROLS_KEY_UP_ESCAPE";
		public static const CONTROLS_KEY_UP_SPACE:String						= "CONTROLS_KEY_UP_SPACE";
		
		public static const ROCKMANAGER_NEW_ROCKLIBRARY:String			        = "ROCKMANAGER_NEW_ROCKLIBRARY";
		public static const ROCKMANAGER_NEW_ROCKCOUNTER:String			        = "ROCKMANAGER_NEW_ROCKCOUNTER";
		public static const ROCKMANAGER_GAME_OVER:String				        = "ROCKMANAGER_GAME_OVER";
		
		public static const SHIPMANAGER_SHIP_ADDED:String		 	            = "SHIPMANAGER_SHIP_ADDED";
		
		public static const MISSLEMANAGER_NEW_MISSLELIBRARY:String	 	        = "MISSLEMANAGER_NEW_MISSLELIBRARY";
		
		public static const HITMANAGER_HIT_SHIP_ROCK:String			            = "HITMANAGER_HIT_SHIP_ROCK";
		public static const HITMANAGER_HIT_MISSLE_ROCK:String		            = "HITMANAGER_HIT_MISSLE_ROCK";
		
		public static const ANIMATIONMANAGER_ANIMATION_END:String		        = "ANIMATION_MANAGER_ANIMATION_END";
				
		public static const GAMEPLAY_START_GAME:String					        = "GAMEPLAY_START_GAME";
		public static const GAMEPLAY_STOP_GAME:String					        = "GAMEPLAY_STOP_GAME";
		public static const GAMEPLAY_NEW_SCORE:String					        = "GAMEPLAY_NEW_SCORE";
		public static const GAMEPLAY_COMBO_BROKEN:String				        = "GAMEPLAY_COMBO_BROKEN";
		public static const GAMEPLAY_NEW_MULTIPLIER:String				        = "GAMEPLAY_NEW_MULTIPLIER";
		public static const GAMEPLAY_NEW_HIGHSCORE:String						= "GAMEPLAY_NEW_HIGHSCORE";
		
		public static const SCREENMANAGER_SCREENSWITCHED:String			        = "SCREENMANAGER_SCREENSWITCHED";

		public static const SETUPMANAGER_SETUP:String					        = "SETUPMANAGER_SETUP";

		public static const STATMANAGER_STATS:String					        = "STATMANAGER_STATS";	

		public static const TO_SHIPMANAGER_ADD_SHIP:String			 	        = "TO_SHIPMANAGER_ADD_SHIP";

		public static const TO_ROCKMANAGER_ADD_ROCK:String			  	        = "TO_ROCKMANAGER_ADD_ROCK";
		
		public static const TO_LEVELSETUP_CREATELEVEL:String			        = "TO_LEVELSETUP_CREATELEVEL";
		
		public static const TO_ANIMATIONMANAGER_ADD_ANIMATION:String            = "TO_ANIMATIONMANAGER_ADD_ANIMATION";
		public static const TO_ANIMATIONMANAGER_ADD_LABELANIMATION:String       = "TO_ANIMATIONMANAGER_ADD_LABELANIMATION";
		public static const TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX:String	= "TO_ANIMATIONMANAGER_PLAY_LABELANIMATIONINDEX";
		public static const TO_ANIMATIONMANAGER_REMOVE_LABELANIMATION:String    = "TO_ANIMATIONMANAGER_REMOVE_LABELANIMATION";
		public static const TO_ANIMATIONMANAGER_PLAY_ANIMATION:String	        = "TO_ANIMATIONMANAGER_PLAY_ANIMATION";
		public static const TO_ANIMAITONMANAGER_REMOVE_ANIMATION:String         = "TO_ANIMATIONMANAGER_REMOVE_ANIMATION";
		public static const TO_ANIMAITONMANAGER_RESET_ANIMATION:String          = "TO_ANIMAITONMANAGER_RESET_ANIMATION";
		
		public static const TO_SCREENMANAGER_ADDSCREEN:String		  	        = "TO_SCREENMANAGER_ADDSCREEN";
		public static const TO_SCREENMANAGER_REMOVESCREEN:String		        = "TO_SCREENMANAGER_REMOVESCREEN";
		public static const TO_SCREENMANAGER_SWITCHSCREEN:String		        = "TO_SCREENMANAGER_SWITCHSCREEN";
		
		public static const TO_STATSMANAGER_SETVOLUME:String					= "TO_STATSMANAGER_SETVOLUME";
		public static const TO_STATSMANAGER_SETLEVEL:String				        = "TO_STATSMANAGER_SETLEVEL";
		
		public static const TO_STATUSMANAGER_STATUS:String				        = "TO_STATUSMANAGER_STATUS";
		
		public static const TO_EXPLOSION_MANAGER_ROCKEXPLOSION:String	        = "TO_EXPLOSION_MANAGER_ROCKEXPLOSION";
		
		public static const TO_SOUNDMANAGER_PLAYSOUND:String					= "TO_SOUNDMANAGER_PLAYSOUND";
		public static const TO_SOUNDMANAGER_SETVOLUME:String					= "TO_SOUNDMANAGER_SETVOLUME";
	}
}
