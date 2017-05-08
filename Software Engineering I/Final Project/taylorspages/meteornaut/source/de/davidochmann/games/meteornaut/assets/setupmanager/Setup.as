package de.davidochmann.games.meteornaut.assets.setupmanager 
{
	/**
	 * @author dochmann
	 */
	 
	public class Setup 
	{
//		private var mStageWidth:uint;
//		private var mStageHeight:uint;
		
		private var mLevelList:Vector.<SetupLevel>;
		
		
		
		public function Setup(/*pStageWidth:uint, pStageHeight:uint*/)
		{			
//			setStageWidth(pStageWidth);
//			setStageHeight(pStageHeight);
			
			initLevelLibrary();		
		}



//		/*
//		 * GETTER FUNCTIONS
//		 */
//		 
//		public function getStageWidth():uint
//		{
//			return mStageWidth;
//		}
//
//		public function getStageHeight():uint
//		{
//			return mStageHeight;
//		}
//
//		/*
//		 * SETTER FUNCTIONS
//		 */
//		 
//		public function setStageWidth(pStageWidth:uint):void
//		{
//			mStageWidth = pStageWidth;
//		}
//		
//		public function setStageHeight(pStageHeight:uint):void
//		{
//			mStageHeight = pStageHeight;
//		}

		
		
		/*
		 * PUBLIC FUNCTIONS
		 */

		public function levelList():Vector.<SetupLevel>
		{
			return mLevelList;
		}

		public function receiveLevelID(pID:uint):SetupLevel
		{
			return mLevelList[pID];	
		}

		public function createLevelMap(pRockMap:Array, pSpeedMap:Array, pDirectionMap:Array):void
		{
			var levelArgs:Array = [0, 0, 0];

			var speedMap:Array = pSpeedMap;
			var directionMap:Array = pDirectionMap;
			
			var rockMapY:Array = pRockMap;
			var rockMapYLength:uint = pRockMap.length;
			var rockSize:Number;
			
			var rockMapX:Array;
			var rockMapXLength:uint;
			
			for(var i:uint = 0; i < rockMapYLength; ++i)
			{
				rockMapX = rockMapY[i];
				rockMapXLength = rockMapX.length;
				
				for(var j:uint = 0; j < rockMapXLength; ++j)
				{
					rockSize = rockMapY[i][j];
					
					if(rockSize == -1)
					{ 
						levelArgs[0] = j * 50;
						levelArgs[1] = i * 50;
					}
				
					if(rockSize != 0  && rockSize != -1) 
						levelArgs.push([rockSize * .1, speedMap[i][j] * .2, j * 50, i * 50, directionMap[i][j]]);
				}
			}

			createLevel.apply(this, levelArgs);
		}

		public function createLevel(pX:int, pY:int, pRotation:uint, ...args:Array):void
		{
			var setupLevel:SetupLevel = new SetupLevel(String(mLevelList.length + 1), mLevelList.length);
			var argsLength:uint = args.length;
			
			var rockList:Array;

			setupLevel.addShip(pX, pY, pRotation);
			
			for(var i:uint = 0; i < argsLength; ++i)
			{
				rockList = args[i] as Array;
				setupLevel.addRock(rockList[2] as int, rockList[3] as int, rockList[4] as Number, rockList[0] as Number, rockList[1] as Number);		
			}
			
			mLevelList.push(setupLevel);
			
			setupLevel.init();
		}

		public function addLevel(pLevel:SetupLevel):void
		{
			pLevel.setID(mLevelList.length);
			mLevelList.push(pLevel);
			pLevel.init();
		}

		
		
		/*
		 * PRIVATE FUNCTIONS
		 */
 
		private function initLevelLibrary():void
		{
			mLevelList = new Vector.<SetupLevel>();
		}
	}
}
