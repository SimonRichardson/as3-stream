package org.osflash.stream.types.vector
{
	import flash.errors.IllegalOperationError;
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.types.vector.packets.IVectorPacket;
	import org.osflash.stream.types.vector.packets.VectorBooleanPacket;
	import org.osflash.stream.types.vector.packets.VectorFloatPacket;
	import org.osflash.stream.types.vector.packets.VectorIntPacket;
	import org.osflash.stream.types.vector.packets.VectorUIntPacket;
	import org.osflash.stream.types.vector.packets.VectorUtfPacket;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class StreamVectorOutput implements IStreamOutput
	{
		
		/**
		 * @private
		 */
		private var _buffer : Vector.<IVectorPacket>;
		
		/**
		 * @private
		 */
		private var _position : int;
		
		public function StreamVectorOutput()
		{
			_buffer = new Vector.<IVectorPacket>();
			_position = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function writeInt(value : int) : void
		{
			const packet : VectorIntPacket = new VectorIntPacket(value);
			
			if(_position == _buffer.length)
				_buffer.push(packet);
			else if(_position < _buffer.length)
				_buffer.splice(_position, 1, packet);
			else 
				throw new IllegalOperationError();
			
			_position++;
		}

		/**
		 * @inheritDoc
		 */
		public function writeUnsignedInt(value : uint) : void
		{
			const packet : VectorUIntPacket = new VectorUIntPacket(value);
			
			if(_position == _buffer.length)
				_buffer.push(packet);
			else if(_position < _buffer.length)
				_buffer.splice(_position, 1, packet);
			else 
				throw new IllegalOperationError();
			
			_position++;
		}

		/**
		 * @inheritDoc
		 */
		public function writeFloat(value : Number) : void
		{
			const packet : VectorFloatPacket = new VectorFloatPacket(value);
			
			if(_position == _buffer.length)
				_buffer.push(packet);
			else if(_position < _buffer.length)
				_buffer.splice(_position, 1, packet);
			else 
				throw new IllegalOperationError();
			
			_position++;
		}

		/**
		 * @inheritDoc
		 */
		public function writeUTF(value : String) : void
		{
			const packet : VectorUtfPacket = new VectorUtfPacket(value);
			if(_position == _buffer.length)
				_buffer.push(packet);
			else if(_position < _buffer.length)
				_buffer.splice(_position, 1, packet);
			else 
				throw new IllegalOperationError();
				
			_position++;
		}

		/**
		 * @inheritDoc
		 */
		public function writeBoolean(value : Boolean) : void
		{
			_buffer.splice(_position, 1, new VectorBooleanPacket(value));
			_position++;
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
		internal function get buffer() : Vector.<IVectorPacket>
		{
			return _buffer;
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
			const input : IStreamInput = new StreamVectorInput(this);
			input.position = _position;
			return input.toString();
		}
	}
}
