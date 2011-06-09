package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class VectorBooleanPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : Boolean;

		public function VectorBooleanPacket(value : Boolean)
		{
			_value = value;
		}
		
		public function get value() : Boolean { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.BOOLEAN; }
	}
}
