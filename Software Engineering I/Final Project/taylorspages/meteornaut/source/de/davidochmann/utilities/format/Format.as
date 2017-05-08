package de.davidochmann.utilities.format
{
	/**
	 * @author dochmann
	 */
	
	public class Format 
	{
		public static function secondsToTime(pSeconds:uint):String
		{
			var minutes:uint = Math.floor(pSeconds / 60);
			var seconds:uint = pSeconds % 60;
			
			var label:String = (minutes == 0) ? "sec" : "min";
			
			var minutesText:String = String(minutes).length < 2 ? ("00" + String(minutes) as String).slice(-2) : String(minutes); 
			var secondsText:String = ("00" + String(seconds) as String).slice(-2);
			
			var time:String = minutesText + ":" + secondsText + " " + label; 
			
			return time;	
		}
		
		public static function score(pCurrentScore:Number, pMaxScore:Number):String
		{
			var score:String;
			
			var zeros:String = "";
			var levelScoreMax:String = String(pMaxScore);
			var levelScoreMaxLength:uint = levelScoreMax.length;
			var levelScore:String = String(pCurrentScore);
			
			for(var i:uint = 0; i < levelScoreMaxLength; ++i) zeros += "0"; 
			levelScore = pCurrentScore != 0 ? String(pCurrentScore) : zeros;

			score = levelScore + " / " + levelScoreMax;
			
			return score;
		}
	}
}
