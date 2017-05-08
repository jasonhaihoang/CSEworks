package de.davidochmann.games.mpshooter.interfaces 
{
	/**
	 * @author dochmann
	 */
	
	public interface IAsset 
	{
		function init():void
		
		function kill():void

		function update():void


		function getID():String

		function getData():Object

		
		function setID(pID:String):void
		
		function setData(pData:Object):void
	}
}
