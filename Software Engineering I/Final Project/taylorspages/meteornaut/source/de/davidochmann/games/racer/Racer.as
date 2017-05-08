package de.davidochmann.games.racer 
{
	import de.davidochmann.games.racer.client.game.ClientGame;

	import flash.display.Sprite;
	import flash.utils.setTimeout;
	//	import fl.motion.BezierSegment;
//
//	import de.davidochmann.games.racer.assets.controls.Controls;
//	import de.davidochmann.games.racer.graphics.embed.Car;
//
//	import flash.display.BitmapData;
//	import flash.display.Graphics;
//	import flash.events.Event;
//	import flash.geom.Point;
//	import flash.geom.Rectangle;
//	import flash.ui.Keyboard;
	
	/**
	 * @author David Ochmann
	 */
	 	
	public class Racer extends Sprite 
	{
		private var mClientMaster:ClientGame;
		
//		private const CAR_ROTATION:Number = 10;
//		private const CAR_MAX_SPEED:Number = .5;
//		private const CAR_BREAK:Number = .03;
//		private const CAR_ACCELERATION:Number = .05;
//		private const CAR_DECCELERATION:Number = .01;
//		
//		private var mPointList:Array;
//		private var mContainer:Sprite;
//				
//		private var mStagePoint:Point;
//		private var mStageRectangle:Rectangle;
//		private var mBitmapDataBorder:BitmapData;
//		private var mBitmapDataCompare:BitmapData;
//	
//		private var mControls:Controls;
//		
//		private var mCar:Car;
		
		
		public function Racer()
		{
			setTimeout(init, 50);	
		}
		
		private function init():void
		{
			initClientMaster();
//			initControls();
//			initBackground();
//			initHitTestObjects();
//			initContainer();
//			initTrack();
//			initCar();
//			initStageEventHandler();
		}

		/*
		 * PRIVATE FUNCTIONS
		 */
		
		private function initClientMaster():void
		{
			mClientMaster = new ClientGame(stage);
		}

		
		
//		/*
//		 * PRIVATE CONTAINER
//		 */
//
//		private function initControls():void
//		{
//			mControls = new Controls(stage);
//		}
//
//		private function initBackground():void
//		{
//			var stw:uint = stage.stageWidth;
//			var sth:uint = stage.stageHeight;
//			
//			graphics.beginFill(0xEFEFEF);
//			graphics.drawRect(0, 0, stw, sth);
//			graphics.endFill();
//		}
//		
//		private function initHitTestObjects():void
//		{
//			var spr:Sprite = new Sprite();
//			var gra:Graphics = spr.graphics;
//			var stw:uint = stage.stageWidth;
//			var sth:uint = stage.stageHeight;
//			
//			gra.beginFill(0xFF0000);
//			gra.drawRect(0, 0, stw, 1);
//			gra.endFill();
//			gra.beginFill(0xFF0000);
//			gra.drawRect(0, 0, 1, sth);
//			gra.endFill();
//			gra.beginFill(0xFF0000);
//			gra.drawRect(stw - 1, 0, 1, sth);
//			gra.endFill();
//			gra.beginFill(0xFF0000);
//			gra.drawRect(0, sth - 1, stw, 1);
//			gra.endFill();
//			
//			mStagePoint = new Point(0, 0);
//			
//			mStageRectangle = new Rectangle(0, 0, stw, sth);
//			
//			mBitmapDataBorder = new BitmapData(stw, sth, true, 0x00000000);
//			mBitmapDataBorder.draw(spr);
//			
//			mBitmapDataCompare = new BitmapData(stw, sth, true, 0x00000000); 
//		}
//
//		private function initContainer():void
//		{
//			mContainer = new Sprite();
//			addChild(mContainer);
//		}
//
//		private function initTrack():void
//		{
//			mPointList = new Array();
//			
//			var stw:uint = stage.stageWidth;
//			var sth:uint = stage.stageHeight;
//			var lng:uint = 10;
//			
//			var pnt:Point;
//			var gra:Graphics = mContainer.graphics;
//
//			var min:uint = 120;
//			var add:uint = 250;
//
//			for(var i:uint = 0; i < lng; ++i)
//			{
//				pnt = new Point((stw * .5) + Math.sin((Math.PI * 2 / lng) * i) * (min + Math.random() * add), (sth * .5) + Math.cos((Math.PI * 2 / lng) * i) * (min + Math.random() *  add));
//				mPointList.push(pnt);
//			}
//			
//			var pn0:Point = Point(mPointList[0]);
//			pnt = new Point(pn0.x, pn0.y);
//			mPointList.push(pnt);
//					
//			var siz:uint = 40;
//					
//			gra.lineStyle(siz, 0x000000);
//			curveThroughPoints(gra, mPointList);
//			gra.endFill();
//			
//			gra.lineStyle(siz - 2, 0xFFFFFF);
//			curveThroughPoints(gra, mPointList);
//			gra.endFill();
//			
//			mBitmapDataCompare.draw(mContainer);
//			
//			if(mBitmapDataBorder.hitTest(mStagePoint, 1, mBitmapDataCompare, mStagePoint))
//			{
//				gra.clear();
//				mBitmapDataCompare.fillRect(mStageRectangle, 0x00000000);
//				
//				initTrack();
//			}			
//		}
//
//		
//		private function initCar():void
//		{
//			mCar = new Car();
//			
//			var pn0:Point = Point(mPointList[0]);
//			
//			mCar.x = pn0.x;
//			mCar.y = pn0.y;
//			
//			mCar.mSpeed = 0;
//			mCar.mDirX = 0;
//			mCar.mDirY = 0;
//			
//			addChild(mCar);
//		}
//
//		private function initStageEventHandler():void 
//		{
//			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
//		}
//
//
//		private function enterFrameHandler(e:Event):void 
//		{
//			validateControls();
//			calculateMovement();
//			moveCar();	
//		}
//
//		private function validateControls():void
//		{
//			if(mControls.pressed(Keyboard.UP)) mCar.mSpeed += CAR_ACCELERATION;
//			if(mControls.pressed(Keyboard.DOWN)) mCar.mSpeed -= CAR_BREAK;
//			if(mControls.pressed(Keyboard.LEFT)) mCar.rotation -= CAR_ROTATION;
//			if(mControls.pressed(Keyboard.RIGHT)) mCar.rotation += CAR_ROTATION;			
//		}
//
//		private function calculateMovement():void
//		{
//			var rot:Number = mCar.rotation;
//			
//			var ang:Number = rot + 180;
//			ang = (ang < 0) ? (ang + 360) : (ang > 360) ? ang - 360 : ang;
//
//			mCar.mSpeed = mCar.mSpeed - CAR_DECCELERATION;
//			mCar.mSpeed = (mCar.mSpeed <= 0) ? 0 : (mCar.mSpeed >= CAR_MAX_SPEED) ? CAR_MAX_SPEED : mCar.mSpeed;
//		
//			mCar.mDirX = -14 * Math.cos(Math.PI / 180 * ang) * mCar.mSpeed;
//			mCar.mDirY =  14 * Math.sin(Math.PI / 180 * ang) * mCar.mSpeed;			
//		}
//
//		private function moveCar():void
//		{
//			mCar.x += mCar.mDirX;
//			mCar.y -= mCar.mDirY;
//		}
//
//		
//		
//		
//		
//		
//		

	}
}
