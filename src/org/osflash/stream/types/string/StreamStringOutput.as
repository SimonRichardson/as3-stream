package org.osflash.stream.types.string
{
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.StreamTypes;

	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamStringOutput implements IStreamOutput
	{
		
		internal static const SEPERATOR : String = ":"; 
		
		/**
		 * @private
		 */
		private var _buffer : String;
		
		/**
		 * @private
		 */
		private var _position : uint;
		
		public function StreamStringOutput()
		{
			_buffer = '';
			_position = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function writeUTF(value : String) : void
		{
			const bit : String = value;
			const length : int = bit.length;
			
			const packet : String = StreamTypes.UTF + "" + length + SEPERATOR + bit;
			
			const parts : Array = _buffer.split('');
			parts.splice(position, 0, packet);
			
			_buffer = parts.join('');
			_position += packet.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function writeInt(value : int) : void
		{
			const bit : String = value.toString();
			const length : int = bit.length;
			
			const packet : String = StreamTypes.INT + "" + length + SEPERATOR + bit;
			
			const parts : Array = _buffer.split('');
			parts.splice(position, 0, packet);
			
			_buffer = parts.join('');
			_position += packet.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function writeUnsignedInt(value : uint) : void
		{
			const bit : String = value.toString();
			const length : int = bit.length;
			
			const packet : String = StreamTypes.UINT + "" + length + SEPERATOR + bit;
			
			const parts : Array = _buffer.split('');
			parts.splice(position, 0, packet);
			
			_buffer = parts.join('');
			_position += packet.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function writeFloat(value : Number) : void
		{
			const bit : String = value.toString();
			const length : int = bit.length;
			
			const packet : String = StreamTypes.FLOAT + "" + length + SEPERATOR + bit;
			
			const parts : Array = _buffer.split('');
			parts.splice(position, 0, packet);
			
			_buffer = parts.join('');
			_position += packet.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function writeBoolean(value : Boolean) : void
		{
			const bit : String = value ? 'true' : 'false';
			const length : int = bit.length;
			
			const packet : String = StreamTypes.BOOLEAN + "" + length + SEPERATOR + bit;
			
			const parts : Array = _buffer.split('');
			parts.splice(position, 0, packet);
			
			_buffer = parts.join('');
			_position += packet.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			_buffer = "";
			_position = 0;
		}
		
		/**
		 * @private
		 */
		internal function get buffer() : String
		{
			return _buffer;
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function get position() : uint
		{
			return _position;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set position(value : uint) : void
		{
			_position = value;
		}
		
		/**
		 * Return the stream as a string
		 */
		public function toString() : String
		{
			var result : String = "";
			
			const input : IStreamInput = new StreamStringInput(this);
			input.position = _position;
			
			var type : int;
			var valid : Boolean = true;
			while(valid)
			{
				type = input.nextType;
				switch(type)
				{
					case StreamTypes.BOOLEAN:
						result += input.readBoolean();
						break;
					case StreamTypes.FLOAT:
						result += input.readFloat();
						break;
					case StreamTypes.INT:
						result += input.readInt();
						break;
					case StreamTypes.UINT:
						result += input.readUnsignedInt();
						break;
					case StreamTypes.UTF:
						result += input.readUTF();
						break;
					case StreamTypes.EOF:
						valid = false;
						break;
					default:
						throw new IllegalOperationError('>>>> ' + type);
						break;
				}
			}
			
			return result;
		}
	}
}
