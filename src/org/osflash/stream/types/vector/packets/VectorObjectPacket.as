package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class VectorObjectPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : Object;

		public function VectorObjectPacket(value : Object)
		{
			_value = value;
		}
		
		public function get value() : Object { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.OBJECT; }
	}
}
