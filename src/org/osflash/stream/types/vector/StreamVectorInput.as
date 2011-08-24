package org.osflash.stream.types.vector
{
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.StreamError;
	import org.osflash.stream.StreamTypes;
	import org.osflash.stream.types.vector.packets.IVectorPacket;
	import org.osflash.stream.types.vector.packets.VectorBooleanPacket;
	import org.osflash.stream.types.vector.packets.VectorFloatPacket;
	import org.osflash.stream.types.vector.packets.VectorIntPacket;
	import org.osflash.stream.types.vector.packets.VectorObjectPacket;
	import org.osflash.stream.types.vector.packets.VectorUIntPacket;
	import org.osflash.stream.types.vector.packets.VectorUtfPacket;
	import org.osflash.stream.types.vector.packets.VectorXMLPacket;

	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class StreamVectorInput implements IStreamInput
	{
		
		/**
		 * @private
		 */
		private var _buffer : Vector.<IVectorPacket>;
		
		/**
		 * @private
		 */
		private var _position : int;
		
		public function StreamVectorInput(stream : IStreamOutput)
		{
			if (!(stream is StreamVectorOutput))
				throw new Error('Missing Implementation');
			
			const output : StreamVectorOutput = StreamVectorOutput(stream);
			output.position = 0;
			
			_buffer = output.buffer;
			_position = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function readInt() : int
		{
			if(readByte() != StreamTypes.INT)
				StreamError.throwError(StreamError.INVALID_INT);
			
			const packet : VectorIntPacket = VectorIntPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}

		/**
		 * @inheritDoc
		 */
		public function readUnsignedInt() : uint
		{
			if(readByte() != StreamTypes.UINT)
				StreamError.throwError(StreamError.INVALID_UINT);
			
			const packet : VectorUIntPacket = VectorUIntPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}

		/**
		 * @inheritDoc
		 */
		public function readFloat() : Number
		{
			if(readByte() != StreamTypes.FLOAT)
				StreamError.throwError(StreamError.INVALID_FLOAT);
			
			const packet : VectorFloatPacket = VectorFloatPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}

		/**
		 * @inheritDoc
		 */
		public function readUTF() : String
		{
			if(readByte() != StreamTypes.UTF)
				StreamError.throwError(StreamError.INVALID_UTF);
			
			const packet : VectorUtfPacket = VectorUtfPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}

		/**
		 * @inheritDoc
		 */
		public function readBoolean() : Boolean
		{
			if(readByte() != StreamTypes.BOOLEAN)
				StreamError.throwError(StreamError.INVALID_BOOLEAN);
			
			const packet : VectorBooleanPacket = VectorBooleanPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function readXML() : XML
		{
			if(readByte() != StreamTypes.XML)
				StreamError.throwError(StreamError.INVALID_XML);
			
			const packet : VectorXMLPacket = VectorXMLPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function readObject() : Object
		{
			if(readByte() != StreamTypes.OBJECT)
				StreamError.throwError(StreamError.INVALID_OBJECT);
			
			const packet : VectorObjectPacket = VectorObjectPacket(_buffer[_position]);
			
			_position++;
			
			return packet.value;
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			_buffer.length = 0;
			_position = 0;
		}
		
		/**
		 * @private
		 */
		private function readByte() : int
		{
			return _buffer[_position].type;
		}

		/**
		 * @inheritDoc
		 */
		public function get nextType() : int
		{
			if(_position >= _buffer.length)
				return StreamTypes.EOF;
			
			return _buffer[_position].type;
		}

		/**
		 * @inheritDoc
		 */
		public function get position() : uint { return _position; }
		public function set position(value : uint) : void { _position = value; }

		/**
		 * @inheritDoc
		 */
		public function toString() : String
		{
			var result : String = "";
			
			var type : int;
			var valid : Boolean = true;
			while(valid)
			{
				type = nextType;
				switch(type)
				{
					case StreamTypes.BOOLEAN:
						result += readBoolean();
						break;
					case StreamTypes.FLOAT:
						result += readFloat();
						break;
					case StreamTypes.INT:
						result += readInt();
						break;
					case StreamTypes.UINT:
						result += readUnsignedInt();
						break;
					case StreamTypes.UTF:
						result += readUTF();
						break;
					case StreamTypes.EOF:
						valid = false;
						break;
					default:
						throw new IllegalOperationError();
						break;
				}
			}
			
			return result;
		}
	}
}
