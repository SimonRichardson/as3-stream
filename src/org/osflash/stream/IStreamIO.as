package org.osflash.stream
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IStreamIO
	{
		
		function read(stream : IStreamInput) : void;
		
		function write(stream : IStreamOutput) : void;
	}
}
