package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class VectorIntPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : int;

		public function VectorIntPacket(value : int)
		{
			_value = value;
		}
		
		public function get value() : int { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.INT; }
	}
}
