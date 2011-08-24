package org.osflash.stream.types.string
{
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.StreamError;
	import org.osflash.stream.StreamTypes;

	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamStringInput implements IStreamInput
	{

		/**
		 * @private
		 */
		private var _buffer : String;
		
		/**
		 * @private
		 */
		private var _position : uint;
		
		/**
		 * @private
		 */
		private var _seperator : int;
		
		public function StreamStringInput(stream : IStreamOutput)
		{
			if (!(stream is StreamStringOutput))
				throw new Error('Missing Implementation');
			
			_seperator = StreamStringOutput.SEPERATOR.charCodeAt(0);

			const output : StreamStringOutput = StreamStringOutput(stream);
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
			
			const length : int = readPacketLength();
			const result : int = parseInt(_buffer.substr(_position, length));
			
			_position += length;
			
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function readUnsignedInt() : uint
		{
			if(readByte() != StreamTypes.UINT)
				StreamError.throwError(StreamError.INVALID_UINT);
				
			const length : int = readPacketLength();
			const result : uint = parseInt(_buffer.substr(_position, length));
			
			_position += length;
			
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function readFloat() : Number
		{
			if(readByte() != StreamTypes.FLOAT)
				StreamError.throwError(StreamError.INVALID_FLOAT);
				
			const length : int = readPacketLength();
			const result : Number = parseFloat(_buffer.substr(_position, length));
			
			_position += length;
			
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function readUTF() : String
		{
			if(readByte() != StreamTypes.UTF)
				StreamError.throwError(StreamError.INVALID_UTF);
				
			const length : int = readPacketLength();
			const result : String = _buffer.substr(_position, length);
			
			_position += length;
			
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function readBoolean() : Boolean
		{
			if(readByte() != StreamTypes.BOOLEAN)
				StreamError.throwError(StreamError.INVALID_BOOLEAN);
				
			const length : int = readPacketLength();
			const result : Boolean = _buffer.substr(_position, length) == "true";
			
			_position += length;
			
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function readXML() : XML
		{
			if(readByte() != StreamTypes.XML)
				StreamError.throwError(StreamError.INVALID_XML);
				
			const length : int = readPacketLength();
			const result : XML = new XML(_buffer.substr(_position, length));
			
			_position += length;
			
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function readObject() : Object
		{
			throw new Error('Operation not supported');
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
		private function readByte() : int
		{
			const byte : int = parseInt(_buffer.substr(_position, 1));
			_position++;
			
			return byte;
		}
		
		/**
		 * @private
		 */
		private function readPacketLength() : int
		{
			var packet : String = "";
			
			const total : int = _buffer.length;
			for(var i : int = _position; i < total; i++)
			{
				if(_buffer.charCodeAt(_position) == _seperator)
				{
					_position++;
					break;
				}
				
				packet += _buffer.charAt(_position);
				
				_position++;
			}
			
			return parseInt(packet);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextType() : int
		{
			if(_position >= _buffer.length)
				return StreamTypes.EOF;
				
			return parseInt(_buffer.substr(_position, 1));
		}

		/**
		 * @inheritDoc
		 */
		public function get position() : uint { return _position; }
		public function set position(value : uint) : void { _position = value; }

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
