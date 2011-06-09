package org.osflash.stream
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IStreamInput
	{
		function readInt() : int;
		
		function readUnsignedInt() : uint;
		
		function readFloat() : Number;
		
		function readUTF() : String;
		
		function readBoolean() : Boolean;
		
		function clear() : void;
		
		function get nextType() : int;
		
		function get position() : uint;
		
		function set position(value : uint) : void;
		
		function toString() : String;
	}
}
