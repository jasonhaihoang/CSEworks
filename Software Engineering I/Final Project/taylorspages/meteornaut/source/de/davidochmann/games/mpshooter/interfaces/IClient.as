package de.davidochmann.games.mpshooter.interfaces 
{
	import flash.display.Sprite;
	
	/**
	 * @author dochmann
	 */

	public interface IClient 
	{
		function init(...args:*):void
		
		function kill():void

		function update():void

		function display():Sprite


		function getID():String

		function getData():Object

		
		function setID(pID:String):void
		
		function setData(pData:Object):void
	}
}
