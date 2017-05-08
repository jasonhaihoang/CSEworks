package de.davidochmann.games.meteornaut 
{
	import net.hires.debug.Stats;

	import de.davidochmann.games.meteornaut.abstracts.AbstractAsset;
	import de.davidochmann.games.meteornaut.assets.animationmanager.AnimationManager;
	import de.davidochmann.games.meteornaut.assets.controls.Controls;
	import de.davidochmann.games.meteornaut.assets.explosionmanager.ExplosionManager;
	import de.davidochmann.games.meteornaut.assets.fontregister.FontRegister;
	import de.davidochmann.games.meteornaut.assets.framehandler.FrameHandler;
	import de.davidochmann.games.meteornaut.assets.game.Game;
	import de.davidochmann.games.meteornaut.assets.gameplay.Gameplay;
	import de.davidochmann.games.meteornaut.assets.hitmanager.HitManager;
	import de.davidochmann.games.meteornaut.assets.misslemanager.MissleManager;
	import de.davidochmann.games.meteornaut.assets.rockmanager.RockManager;
	import de.davidochmann.games.meteornaut.assets.screenabout.ScreenAbout;
	import de.davidochmann.games.meteornaut.assets.screencontrols.ScreenControls;
	import de.davidochmann.games.meteornaut.assets.screengameover.ScreenGameOver;
	import de.davidochmann.games.meteornaut.assets.screenlevel.ScreenLevel;
	import de.davidochmann.games.meteornaut.assets.screenlevelselect.ScreenLevelSelect;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenID;
	import de.davidochmann.games.meteornaut.assets.screenmanager.ScreenManager;
	import de.davidochmann.games.meteornaut.assets.screensettings.ScreenSettings;
	import de.davidochmann.games.meteornaut.assets.screenstats.ScreenStats;
	import de.davidochmann.games.meteornaut.assets.screentitle.ScreenTitle;
	import de.davidochmann.games.meteornaut.assets.setupmanager.SetupManager;
	import de.davidochmann.games.meteornaut.assets.shipmanager.ShipManager;
	import de.davidochmann.games.meteornaut.assets.soundmanager.SoundManager;
	import de.davidochmann.games.meteornaut.assets.statsmanager.StatsManager;
	import de.davidochmann.games.meteornaut.assets.statusmanager.StatusManager;
	import de.davidochmann.games.meteornaut.interfaces.IDisplayHolder;
	import de.davidochmann.games.meteornaut.interfaces.IStageHolder;
	import de.davidochmann.games.meteornaut.notification.Notification;
	import de.davidochmann.namespaces.DEBUG;

	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * @author dochmann
	 */

	[Frame(factoryClass="de.davidochmann.games.meteornaut.preloader.Preloader")]
	
	public class Meteornaut extends Sprite
	{
		private var mGame:AbstractAsset;
		private var mFontRegister:FontRegister;
		private var mShipManager:AbstractAsset;
		private var mControls:AbstractAsset;
		private var mMissleManager:AbstractAsset;
		private var mRockManager:AbstractAsset;
		private var mHitManager:AbstractAsset;
		private var mAnimationManager:AbstractAsset;
		private var mExplosionManager:AbstractAsset;
		private var mGameplay:AbstractAsset;
		private var mStatusManager:AbstractAsset;
		private var mFrameHandler:AbstractAsset;
		private var mScreenLevel:AbstractAsset;
		private var mScreenLevelSelect:AbstractAsset;
		private var mScreenGameOver:AbstractAsset;
		private var mScreenTitle:AbstractAsset;
		private var mScreenStats:AbstractAsset;
		private var mScreenControls:AbstractAsset;
		private var mScreenSettings:AbstractAsset;
		private var mScreenAbout:AbstractAsset;
		private var mScreenManager:AbstractAsset;
		private var mStatsManager:AbstractAsset;
		private var mSoundManager:AbstractAsset;
		private var mSetupManager:AbstractAsset;
		
		public function Meteornaut(){}
		
		public function init(pStage:Stage):void
		{
			mGame		  	   = new Game("game", null);
			mSoundManager	   = new SoundManager("soundManager", mGame);
			mStatsManager	   = new StatsManager("statsManager", mGame);
			mFontRegister	   = new FontRegister("fontRegister", mGame);
			mShipManager  	   = new ShipManager("shipManager", mGame);
			mControls	  	   = new Controls("controls", mGame);
			mHitManager	   	   = new HitManager("hitManager", mGame);
			mGameplay		   = new Gameplay("gameplay", mGame);
			mMissleManager	   = new MissleManager("missleManager", mGame);
			mRockManager   	   = new RockManager("rockManager", mGame);
			mAnimationManager  = new AnimationManager("animationManager", mGame);
			mExplosionManager  = new ExplosionManager("explosionManager", mGame);
			mStatusManager	   = new StatusManager("statusManager", mGame);
			mScreenLevel       = new ScreenLevel("screenLevel", mGame);
			mScreenLevelSelect = new ScreenLevelSelect("screenlevelSelect", mGame);
			mFrameHandler 	   = new FrameHandler("frameHandler", mGame);
			mScreenGameOver	   = new ScreenGameOver("screenGameOver", mGame);
			mScreenTitle	   = new ScreenTitle("screenTitle", mGame);
			mScreenStats	   = new ScreenStats("screenStats", mGame);
			mScreenManager	   = new ScreenManager("screenManager", mGame);
			mScreenControls	   = new ScreenControls("screenControls", mGame);
			mScreenSettings	   = new ScreenSettings("screenSettings", mGame);
			mScreenAbout	   = new ScreenAbout("screenAbout", mGame);
			mSetupManager	   = new SetupManager("setupManager", mGame);
			
			
			IStageHolder(mGame).setStage(pStage);
			mGame.init();
						
			addChild(IDisplayHolder(mScreenManager).display());
			
			
			if(DEBUG::debug)
			{
				var stats:Stats = new Stats();
				stats.x = stats.y = 10;
				addChild(stats);

				mScreenManager.call(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_TITLE);
			}
			else
				mScreenManager.call(Notification.TO_SCREENMANAGER_SWITCHSCREEN, ScreenID.SCREEN_TITLE);
		}
	}
}
