package de.davidochmann.games.meteornaut.assets.soundmanager 
{
	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.games.meteornaut.sounds.SoundCountdown;
	import de.davidochmann.games.meteornaut.sounds.SoundExplosion;
	import de.davidochmann.games.meteornaut.sounds.SoundGameover;
	import de.davidochmann.games.meteornaut.sounds.SoundGo;
	import de.davidochmann.games.meteornaut.sounds.SoundLaser0;
	import de.davidochmann.games.meteornaut.sounds.SoundLaser1;
	import de.davidochmann.games.meteornaut.sounds.SoundLaser2;
	import de.davidochmann.games.meteornaut.sounds.SoundPowerup;
	import de.davidochmann.games.meteornaut.sounds.SoundSelect;

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	/**
	 * @author David Ochmann
	 */
	 
	public class SoundManager extends AbstractAsset 
	{
		private var mSoundLibrary:Dictionary;
		
		private var mSoundID:String;
		private var mSound:Sound;
		private var mSoundChannel:SoundChannel;
		private var mSoundTransform:SoundTransform;


		
		public function SoundManager(pID:String, pParent:AbstractAsset)
		{
			super(pID, pParent);
		}
		
		
		
		/*
		 * PUBLIC FUNCTIONS
		 */
		 
		override public function init():void
		{
			register(Notification.GAME_SETUP);
			register(Notification.TO_SOUNDMANAGER_PLAYSOUND);
			register(Notification.TO_SOUNDMANAGER_SETVOLUME);		}

		override public function kill():void
		{
			unregister(Notification.GAME_SETUP);
			unregister(Notification.TO_SOUNDMANAGER_PLAYSOUND);
			unregister(Notification.TO_SOUNDMANAGER_SETVOLUME);
		}
		
		override public function call(pState:String, ...args:Array):void
		{
			switch(pState)
			{
				case Notification.GAME_SETUP:
					initSounds();
					break;
					
				case Notification.TO_SOUNDMANAGER_SETVOLUME:
					mSoundTransform.volume = args[0] as Number;
					break;
					
				case Notification.TO_SOUNDMANAGER_PLAYSOUND:
					mSoundID = args[0] as String;
					playSound(mSoundID);
					break;
			}
		}



		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initSounds():void 
		{
			mSoundLibrary = new Dictionary();
			
			mSoundLibrary[SoundID.EXPLOSION] = new SoundExplosion();
			mSoundLibrary[SoundID.GAMEOVER]	 = new SoundGameover();;
			mSoundLibrary[SoundID.LASER0] 	 = new SoundLaser0();			mSoundLibrary[SoundID.LASER1] 	 = new SoundLaser1();			mSoundLibrary[SoundID.LASER2] 	 = new SoundLaser2();			mSoundLibrary[SoundID.SELECT]	 = new SoundSelect();			mSoundLibrary[SoundID.COUNTDOWN] = new SoundCountdown();
			mSoundLibrary[SoundID.POWERUP]	 = new SoundPowerup();			mSoundLibrary[SoundID.GO]	 	 = new SoundGo();
			
			mSoundTransform = new SoundTransform();
		}

		private function playSound(pID:String):void
		{
			mSound = mSoundLibrary[pID] as Sound;
			
			mSoundChannel = mSound.play();
			mSoundChannel.soundTransform = mSoundTransform;
		}
	}
}
