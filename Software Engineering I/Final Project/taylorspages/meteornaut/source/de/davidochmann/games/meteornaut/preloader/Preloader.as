package de.davidochmann.games.meteornaut.preloader
{
	import de.davidochmann.games.meteornaut.graphics.embed.PreloaderEmbed;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * @author dochmann
	 */
	
	[SWF(width="800", height="500", frameRate="31", backgroundColor="#838383")]
	
	public class Preloader extends MovieClip 
	{
		private var mPrelaoderEmbed:PreloaderEmbed;		

	
		
		public function Preloader()
		{
			stop();

			initPreloaderEmbed();
			initLoaderInfo();
			initEnterFrameHandler();
		}


		
		/*
		 * PRIVATE FUNCTIONS
		 */

		private function initPreloaderEmbed():void
		{
			mPrelaoderEmbed = new PreloaderEmbed();
			
			mPrelaoderEmbed.mBar.scaleX = 1;
			mPrelaoderEmbed.mLabel.text = "000%";
			
			addChild(mPrelaoderEmbed);
		}

		/*
		 * INIT PRELOADER
		 */

		private function initLoaderInfo():void 
		{
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfoProgressHandler);
		}

		private function loaderInfoProgressHandler(e:ProgressEvent):void 
		{
			var scale:Number = e.bytesLoaded / e.bytesTotal;
			var percent:Number = Math.round(scale * 100);
			
			mPrelaoderEmbed.mBar.scaleX = scale;
			mPrelaoderEmbed.mLabel.text = ("000" + percent).slice(-3) + "%"; 
		}

		/*
		 * ENTERFRAME FUNCTIONS
		 */
		
		private function initEnterFrameHandler():void 
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(e:Event):void 
		{
            if(framesLoaded >= totalFrames)
            {
                removeChild(mPrelaoderEmbed);
				mPrelaoderEmbed = null;

                removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
                nextFrame();
                
                var mainClass:Class = Class(getDefinitionByName("de.davidochmann.games.meteornaut.Meteornaut"));
	            
	            if(mainClass)
	            {
	                var game:Object = new mainClass();
	                addChild(game as DisplayObject);
					game.init(stage);
				}
            }
		}
	}
}
