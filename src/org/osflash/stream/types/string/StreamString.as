package org.osflash.stream.types.string
{
	import org.osflash.stream.IStreamInput;
	import org.osflash.stream.IStreamOutput;
	import org.osflash.stream.StreamError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamString implements IStreamInput, IStreamOutput
	{

		/**
		 * @private
		 */
		private var _input : IStreamInput;

		/**
		 * @private
		 */
		private var _output : IStreamOutput;

		public function StreamString()
		{
			_output = new StreamStringOutput();
			_input = new StreamStringInput(_output);
		}
		
		/**
		 * @inheritDoc
		 */
		public function readInt() : int
		{
			return _input.readInt();
		}

		/**
		 * @inheritDoc
		 */
		public function writeInt(value : int) : void
		{
			_output.writeInt(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readUnsignedInt() : uint
		{
			return _input.readUnsignedInt();
		}

		/**
		 * @inheritDoc
		 */
		public function writeUnsignedInt(value : uint) : void
		{
			_output.writeUnsignedInt(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readFloat() : Number
		{
			return _input.readFloat();
		}

		/**
		 * @inheritDoc
		 */
		public function writeFloat(value : Number) : void
		{
			_output.writeFloat(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readUTF() : String
		{
			return _input.readUTF();
		}

		/**
		 * @inheritDoc
		 */
		public function writeUTF(value : String) : void
		{
			_output.writeUTF(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readBoolean() : Boolean
		{
			return _input.readBoolean();
		}

		/**
		 * @inheritDoc
		 */
		public function writeBoolean(value : Boolean) : void
		{
			_output.writeBoolean(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readXML() : XML
		{
			return _input.readXML();
		}

		/**
		 * @inheritDoc
		 */
		public function writeXML(value : XML) : void
		{
			_output.writeXML(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function readObject() : Object
		{
			return _input.readObject();
		}

		/**
		 * @inheritDoc
		 */
		public function writeObject(value : Object) : void
		{
			_output.writeObject(value);
			_input.position = _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			_input.clear();
			_output.clear();
		}

		/**
		 * @inheritDoc
		 */
		public function get position() : uint
		{
			if(_output.position != _input.position) 
				throw new StreamError('IO Stream position mismatch');	
			return _output.position;
		}

		/**
		 * @inheritDoc
		 */
		public function set position(value : uint) : void
		{
			_input.position = value;
			_output.position = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get nextType() : int { return _input.nextType; }

		/**
		 * @inheritDoc
		 */
		public function toString() : String
		{
			return _input.toString();
		}
	}
}
