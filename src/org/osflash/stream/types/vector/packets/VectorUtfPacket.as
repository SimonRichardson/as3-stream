package org.osflash.stream.types.vector.packets
{
	import org.osflash.stream.StreamTypes;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class VectorUtfPacket implements IVectorPacket
	{
		
		/**
		 * @private
		 */
		private var _value : String;

		public function VectorUtfPacket(value : String)
		{
			_value = value;
		}
		
		public function get value() : String { return _value; }
		
		/**
		 * @inheritDoc
		 */
		public function get type() : int { return StreamTypes.UTF; }
	}
}
