package de.davidochmann.utilities.calculator 
{
	import flash.geom.Point;
	/**
	 * @author dochmann
	 */
	 
	public class Calculator 
	{
		private static var mPoint:Point;
		private static var mAngle:Number;
		private static var mPositionX:Number;
		private static var mPositionY:Number;
		
		
		public static function rotationToPoint(pRotation:Number):Point
		{
			mPoint = new Point();
						
			mAngle = pRotation + 180;
			mAngle = mAngle < 0 ? mAngle + 360 : mAngle > 360 ? mAngle - 360 : mAngle;
			
			mPoint.x = Math.cos(Math.PI / 180 * mAngle);
			mPoint.y = Math.sin(Math.PI / 180 * mAngle);
			
			return mPoint;
		}
		
		public static function rotationToPositionX(pRotation:Number):Number
		{		
			mAngle = pRotation + 180;
			mAngle = mAngle < 0 ? mAngle + 360 : mAngle > 360 ? mAngle - 360 : mAngle;
			
			mPositionY = Math.cos(Math.PI / 180 * mAngle);
			
			return mPositionY;
		}
		
		public static function rotationToPositionY(pRotation:Number):Number
		{	
			mAngle = pRotation + 180;
			mAngle = mAngle < 0 ? mAngle + 360 : mAngle > 360 ? mAngle - 360 : mAngle;
			
			mPositionX = Math.sin(Math.PI / 180 * mAngle);
			
			return mPositionX;
		}
	}
}
