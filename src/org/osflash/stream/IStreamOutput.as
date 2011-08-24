package org.osflash.stream
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IStreamOutput
	{
		function writeInt(value : int) : void;
		
		function writeUnsignedInt(value : uint) : void;
		
		function writeFloat(value : Number) : void;
		
		function writeUTF(value : String) : void;
		
		function writeBoolean(value : Boolean) : void;
		
		function writeXML(value : XML) : void;
		
		function writeObject(value : Object) : void;
		
		function clear() : void;
		
		function get position() : uint;
		
		function set position(value : uint) : void;
		
		function toString() : String;
	}
}
