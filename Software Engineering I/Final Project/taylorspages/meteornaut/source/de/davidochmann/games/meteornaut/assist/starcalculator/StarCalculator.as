package de.davidochmann.games.meteornaut.assist.starcalculator 
{
	/**
	 * @author dochmann
	 */
	 
	public class StarCalculator 
	{
		private static var mStars:uint;
		
		
		public static function calculate(pScore:uint, pMaxScore:uint):uint
		{
			mStars = pScore == 0 ? 0 : (pScore < pMaxScore * .5 ? 1 : pScore == pMaxScore ? 3 : 2);
			return mStars;
		}
	}
}
