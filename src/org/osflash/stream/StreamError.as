package org.osflash.stream
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamError extends Error
	{

		public static const INVALID_INT : int = 0x01;

		public static const INVALID_UINT : int = 0x02;

		public static const INVALID_FLOAT : int = 0x03;

		public static const INVALID_UTF : int = 0x04;

		public static const INVALID_BOOLEAN : int = 0x05;

		public function StreamError(message : String)
		{
			super(message);
		}

		public static function throwError(type : int) : void
		{
			switch(type)
			{
				case INVALID_INT:
					throw new StreamError('Invalid int');
					break;
				case INVALID_UINT:
					throw new StreamError('Invalid uint');
					break;
				case INVALID_FLOAT:
					throw new StreamError('Invalid float');
					break;
				case INVALID_UTF:
					throw new StreamError('Invalid utf');
					break;
				case INVALID_BOOLEAN:
					throw new StreamError('Invalid boolean');
					break;
				default:
					throw new ArgumentError('Given argument is Unknown');
			}
		}
	}
}
