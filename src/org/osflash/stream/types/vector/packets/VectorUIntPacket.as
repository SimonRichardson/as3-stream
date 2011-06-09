package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class VectorUIntPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : uint;

		public function VectorUIntPacket(value : uint)
		{
			_value = value;
		}
		
		public function get value() : uint { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.UINT; }
	}
}
