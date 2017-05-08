package de.davidochmann.games.meteornaut.assets.setupmanager 
{
//	import de.davidochmann.namespaces.DEBUG;
//	import flash.utils.Dictionary;

	/**
	 * @author dochmann
	 */

	public class SetupLevel 
	{
		private var mID:uint;
		private var mName:String;
		
		private var mShip:Object;
		private var mRockList:Vector.<Object>;
		private var mMaxScore:uint;
		private var mMaxCombo:uint;
		
		
		
		public function SetupLevel(pName:String, pID:uint = 0)
		{
			setID(pID);
			setName(pName);
			
			initShip();
			initRockList();	
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getID():uint
		{
			return mID;
		}
		
		public function getName():String
		{
			return mName;
		}

		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setID(pID:uint):void
		{
			mID = pID;
		}

		public function setName(pName:String):void
		{
			mName = pName;	
		}


		
		/*
		 * PUBLIC FUNCTIONS
		 */
		
		public function init():void
		{			
			var rockListLength:uint = mRockList.length;
			
			var rockObject:Object;
			var rockScale:Number;

			var rockDivisions:uint;
			var rockCount:uint;

			/*
			var scaleLibrary:Dictionary = new Dictionary();			
			*/

			var rockTotal:uint;
			
			for(var i:uint = 0; i < rockListLength; ++i)
			{
				rockObject	  = mRockList[i] as Object;
				rockScale	  = rockObject.scale;
				rockDivisions = 1 + Math.floor(rockScale * 10);
				rockCount	  = 1;
				
				while(rockDivisions > 1)
				{
					rockDivisions--;
					
					/*
					if(scaleLibrary[rockDivisions] == undefined) scaleLibrary[rockDivisions] = 0;
					scaleLibrary[rockDivisions] += rockCount;
					/*/
					rockTotal += rockCount;
					//*/

					rockCount *= 2;
				} 
			}

			mMaxCombo = rockTotal;
			mMaxScore = rockTotal * rockTotal * 10;

//			if(DEBUG::debug) trace("level", ("00" + String(mID + 1) as String).slice(-2), mMaxCombo, mMaxScore);
			
			/*
			for(var key:Object in scaleLibrary)
			{
				rockCount = scaleLibrary[key];	
				mMaxScore += (10 * rockCount) * rockCount;
			}
			*/
		}

		public function maxScore():uint
		{
			return mMaxScore;
		}

		public function maxCombo():uint
		{
			return mMaxCombo;
		}

		public function ship():Object
		{
			return mShip;
		}

		public function addShip(pX:int, pY:int, pDirection:Number):void
		{
			mShip.x			= pX;
			mShip.y			= pY;
			mShip.direction = pDirection;
		}

		public function rockList():Vector.<Object>
		{
			return mRockList;	
		}
		
		public function addRock(pX:int, pY:int, pDirection:Number, pScale:Number, pSpeed:Number):void
		{
			var rockObject:Object = new Object();
			
			rockObject.x		 = pX;
			rockObject.y		 = pY;
			rockObject.direction = pDirection;
			rockObject.scale	 = pScale;
			rockObject.speed	 = pSpeed;
			
			mRockList.push(rockObject); 
		}



		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initShip():void
		{
			mShip = new Object();
		}

		private function initRockList():void
		{
			mRockList = new Vector.<Object>();
		}
	}
}
