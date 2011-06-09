package org.osflash.stream.types.bytearray
{
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.StreamError;
	import org.osflash.stream.StreamTypes;
	import org.osflash.stream.types.string.StreamStringOutput;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamByteArrayInput implements IStreamInput
	{

		/**
		 * @private
		 */
		private var _buffer : ByteArray;

		public function StreamByteArrayInput(stream : IStreamOutput)
		{
			if (!(stream is StreamByteArrayOutput))
				throw new Error('Missing Implementation');

			const output : StreamByteArrayOutput = StreamByteArrayOutput(stream);
			output.position = 0;
			
			_buffer = output.buffer;
			_buffer.position = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function readInt() : int
		{
			if(_buffer.readByte() != StreamTypes.INT)
				StreamError.throwError(StreamError.INVALID_INT);
				
			return _buffer.readInt();
		}

		/**
		 * @inheritDoc
		 */
		public function readUnsignedInt() : uint
		{
			if(_buffer.readByte() != StreamTypes.UINT)
				StreamError.throwError(StreamError.INVALID_UINT);
				
			return _buffer.readUnsignedInt();
		}

		/**
		 * @inheritDoc
		 */
		public function readFloat() : Number
		{
			if(_buffer.readByte() != StreamTypes.FLOAT)
				StreamError.throwError(StreamError.INVALID_FLOAT);
				
			return _buffer.readFloat();
		}

		/**
		 * @inheritDoc
		 */
		public function readUTF() : String
		{
			if(_buffer.readByte() != StreamTypes.UTF)
				StreamError.throwError(StreamError.INVALID_UTF);
				
			return _buffer.readUTF();
		}

		/**
		 * @inheritDoc
		 */
		public function readBoolean() : Boolean
		{
			if(_buffer.readByte() != StreamTypes.BOOLEAN)
				StreamError.throwError(StreamError.INVALID_BOOLEAN);
				
			return _buffer.readBoolean();
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			_buffer.clear();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get nextType() : int
		{
			const pos : uint = _buffer.position;
			if(pos >= _buffer.length)
				return StreamTypes.EOF;
			
			const type : int = _buffer.readByte();
			_buffer.position = pos;
			
			return type;
		}

		/**
		 * @inheritDoc
		 */
		public function get position() : uint { return _buffer.position; }
		public function set position(value : uint) : void { _buffer.position = value; }

		public function toString() : String
		{
			const stream : IStreamOutput = new StreamStringOutput();
			
			while(_buffer.position < _buffer.length)
			{
				switch(_buffer.readByte())
				{
					case StreamTypes.UTF: 
						stream.writeUTF(_buffer.readUTF()); 
						break;
					case StreamTypes.INT: 
						stream.writeInt(_buffer.readInt()); 
						break;
					case StreamTypes.UINT: 
						stream.writeUnsignedInt(_buffer.readUnsignedInt()); 
						break;
					case StreamTypes.FLOAT: 
						stream.writeFloat(_buffer.readFloat()); 
						break;
					case StreamTypes.BOOLEAN: 
						stream.writeBoolean(_buffer.readBoolean()); 
						break;
					default: 
						throw new IllegalOperationError();
						break;
				}
			}
			
			stream.position = 0;
			
			return stream.toString();
		}
	}
}
