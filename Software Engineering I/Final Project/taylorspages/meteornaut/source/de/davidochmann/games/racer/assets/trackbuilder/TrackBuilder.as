package de.davidochmann.games.racer.assets.trackbuilder 
{
	import fl.motion.BezierSegment;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author dochmann
	 */

	public class TrackBuilder 
	{
		private var mStagePoint:Point;
		private var mStageRectangle:Rectangle;
		private var mBitmapDataBorder:BitmapData;
		private var mBitmapDataCompare:BitmapData;
		private var mStage:Stage;

		
		
		public function TrackBuilder(pStage:Stage)
		{
			setStage(pStage);
			initStageObjects();
		}
		
		
		
		/*
		 * GETTER FUNCTIONS
		 */
		 
		public function getStage():Stage
		{
			return mStage; 
		}
		
		
		
		/*
		 * SETTER FUNCTIONS
		 */
		 
		public function setStage(pStage:Stage):void
		{
			mStage = pStage;
		}
		
		private function initStageObjects():void
		{
			var spr:Sprite = new Sprite();
			var gra:Graphics = spr.graphics;
			var stw:uint = mStage.stageWidth;
			var sth:uint = mStage.stageHeight;
			
			gra.beginFill(0xFF0000);
			gra.drawRect(0, 0, stw, 1);
			gra.endFill();
			gra.beginFill(0xFF0000);
			gra.drawRect(0, 0, 1, sth);
			gra.endFill();
			gra.beginFill(0xFF0000);
			gra.drawRect(stw - 1, 0, 1, sth);
			gra.endFill();
			gra.beginFill(0xFF0000);
			gra.drawRect(0, sth - 1, stw, 1);
			gra.endFill();
			
			mStagePoint = new Point(0, 0);
			
			mStageRectangle = new Rectangle(0, 0, stw, sth);
			
			mBitmapDataBorder = new BitmapData(stw, sth, true, 0x00000000);
			mBitmapDataBorder.draw(spr);
			
			mBitmapDataCompare = new BitmapData(stw, sth, true, 0x00000000); 
		}
		
		
		
		/*	
		 * PUBLIC FUNCTIONS
		 */
		
		public function track(pPointList:Array):Sprite
		{
			var trk:Sprite = new Sprite();
			
			pPointList = new Array();
			
			var stw:uint = mStage.stageWidth;
			var sth:uint = mStage.stageHeight;
			var lng:uint = 10;
			
			var pnt:Point;
			var gra:Graphics = trk.graphics;

			var min:uint = 120;
			var add:uint = 250;

			for(var i:uint = 0; i < lng; ++i)
			{
				pnt = new Point((stw * .5) + Math.sin((Math.PI * 2 / lng) * i) * (min + Math.random() * add), (sth * .5) + Math.cos((Math.PI * 2 / lng) * i) * (min + Math.random() *  add));
				pPointList.push(pnt);
			}
			
			var pn0:Point = Point(pPointList[0]);
			pnt = new Point(pn0.x, pn0.y);
			pPointList.push(pnt);
					
			var siz:uint = 40;
					
			gra.lineStyle(siz, 0x000000);
			curveThroughPoints(gra, pPointList);
			gra.endFill();
			
			gra.lineStyle(siz - 2, 0xFFFFFF);
			curveThroughPoints(gra, pPointList);
			gra.endFill();
			
			mBitmapDataCompare.draw(trk);
			
			if(mBitmapDataBorder.hitTest(mStagePoint, 1, mBitmapDataCompare, mStagePoint))
			{
				gra.clear();
				mBitmapDataCompare.fillRect(mStageRectangle, 0x00000000);
				
				track(pPointList);
			}
			
			return trk;
		}
		
		
		
		
		/*
		 * CURVE TROUGH POINTS @author: Andy Woodruff
		 */
		
		public static function curveThroughPoints(pGraphics:Graphics, pPointList:Array, pZ:Number = .5, pAngleFactor:Number = .75, pMoveTo:Boolean = true):void
		{
			try 
			{
				var p:Array = pPointList.slice();
				var duplicates:Array = new Array();

				for(var i:int = 0; i < p.length; ++i)
				{
					if(!(p[i] is Point)) throw new Error("Array must contain Point objects");
					if(i > 0) if(Point(p[i]).x == Point(p[i-1]).x && Point(p[i]).y == Point(p[i-1]).y) duplicates.push(i);
				}
				
				for(i = duplicates.length - 1; i >= 0; --i) p.splice(duplicates[i],1);
				
				if(pZ <= 0) pZ = .5;
				else if(pZ > 1) pZ = 1;
				
				if(pAngleFactor < 0) pAngleFactor = 0;
				else if(pAngleFactor > 1) pAngleFactor = 1;
				

				if(p.length > 2)
				{
					var firstPt:uint = 1;
					var lastPt:uint = p.length-1;
				
					if(Point(p[0]).x == Point(p[p.length-1]).x && Point(p[0]).y == Point(p[p.length-1]).y)
					{
						firstPt = 0;
						lastPt = p.length;
					}
					
					var controlPts:Array = new Array();
					
					for(i = firstPt; i < lastPt; ++i) 
					{
						var p0:Point = (i-1 < 0) ? p[p.length-2] : p[i-1];
						var p1:Point = p[i];
						var p2:Point = (i+1 == p.length) ? p[1] : p[i+1];
						var a:Number = Point.distance(p0 , p1);
						
						if(a < 0.001) a = .001;
						var b:Number = Point.distance(p1,p2);
						
						if(b < 0.001) b = .001;
						var c:Number = Point.distance(p0,p2);
						
						if(c < 0.001) c = .001;
						var cos:Number = (b*b+a*a-c*c) / (2*b*a);

						if(cos < -1) cos = -1;
						else if(cos > 1) cos = 1;
						var C:Number = Math.acos(cos);
						
						var aPt:Point = new Point(p0.x-p1.x,p0.y-p1.y);
						var bPt:Point = new Point(p1.x,p1.y);
						var cPt:Point = new Point(p2.x-p1.x,p2.y-p1.y);


						if(a > b) aPt.normalize(b);
						else if(b > a) cPt.normalize(a);

						aPt.offset(p1.x,p1.y);
						cPt.offset(p1.x,p1.y);

						var ax:Number = bPt.x - aPt.x;
						var ay:Number = bPt.y - aPt.y; 
						var bx:Number = bPt.x - cPt.x;
						var by:Number = bPt.y - cPt.y;
						var rx:Number = ax + bx;
						var ry:Number = ay + by;

						if(rx == 0 && ry == 0)
						{
							rx = -bx;
							ry = by;
						}
						
						if(ay == 0 && by == 0)
						{
							rx = 0;
							ry = 1;
						} 
						else if(ax == 0 && bx == 0)
						{
							rx = 1;
							ry = 0;
						}

						var theta:Number = Math.atan2(ry,rx);
						
						var controlDist:Number = Math.min(a,b) * pZ;
						var controlScaleFactor:Number = C/Math.PI;
						controlDist *= ((1 - pAngleFactor) + pAngleFactor * controlScaleFactor);
						
						var controlAngle:Number = theta+Math.PI/2;
						var controlPoint2:Point = Point.polar(controlDist,controlAngle);
						var controlPoint1:Point = Point.polar(controlDist,controlAngle+Math.PI);
						
						controlPoint1.offset(p1.x,p1.y);
						controlPoint2.offset(p1.x,p1.y);
						
						if(Point.distance(controlPoint2,p2) > Point.distance(controlPoint1, p2)) controlPts[i] = new Array(controlPoint2, controlPoint1);
						else controlPts[i] = new Array(controlPoint1,controlPoint2);
					}
					
					
					if(pMoveTo) pGraphics.moveTo(Point(p[0]).x, Point(p[0]).y);
					else pGraphics.lineTo(Point(p[0]).x, Point(p[0]).y);
					if(firstPt == 1) pGraphics.curveTo(Point((controlPts[1] as Array)[0]).x, Point((controlPts[1] as Array)[0]).y, Point(p[1]).x, Point(p[1]).y);
					
					var straightLines:Boolean = true;
					
					for(i = firstPt; i < lastPt - 1; i++)
					{
						var isStraight:Boolean = ((i > 0 && Math.atan2(Point(p[i]).y - Point(p[i-1]).y, Point(p[i]).x - Point(p[i-1]).x) == Math.atan2(Point(p[i+1]).y - Point(p[i]).y, Point(p[i+1]).x - Point(p[i]).x)) || (i < p.length - 2 && Math.atan2(Point(p[i+2]).y - Point(p[i+1]).y, Point(p[i+2]).x - Point(p[i+1]).x) == Math.atan2(Point(p[i+1]).y - Point(p[i]).y, Point(p[i+1]).x - Point(p[i]).x)));
						if(straightLines && isStraight) pGraphics.lineTo(Point(p[i+1]).x, Point(p[i+1]).y);
						else 
						{
							var bezier:BezierSegment = new BezierSegment(p[i],controlPts[i][1],controlPts[i+1][0],p[i+1]);
							for(var t:Number = .01; t < 1.01; t+=.01)
							{
								var val:Point = bezier.getValue(t);
								pGraphics.lineTo(val.x,val.y);
							}
						}
					}
					if(lastPt == p.length-1) pGraphics.curveTo(Point(controlPts[i][1]).x, Point(controlPts[i][1]).y, Point(p[i+1]).x, Point(p[i+1]).y);
				} 
				else if(p.length == 2)
				{	
					pGraphics.moveTo(Point(p[0]).x, Point(p[0]).y);
					pGraphics.lineTo(Point(p[1]).x, Point(p[1]).y);
				}
			} 
			
			catch(e:Error){ trace(e.getStackTrace()); };
		}
	}
}
