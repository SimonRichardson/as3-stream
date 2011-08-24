package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class VectorXMLPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : XML;

		public function VectorXMLPacket(value : XML)
		{
			_value = value;
		}
		
		public function get value() : XML { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.XML; }
	}
}
