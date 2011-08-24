package org.osflash.stream
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class StreamError extends Error
	{
		
		private static const STREAM : int = 1000;

		public static const INVALID_INT : int = STREAM | 0x0001;

		public static const INVALID_UINT : int = STREAM | 0x0002;

		public static const INVALID_FLOAT : int = STREAM | 0x0003;

		public static const INVALID_UTF : int = STREAM | 0x0004;

		public static const INVALID_BOOLEAN : int = STREAM | 0x0005;
		
		public static const INVALID_XML : int = STREAM | 0x0005;
		
		public static const INVALID_OBJECT : int = STREAM | 0x0005;

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
				case INVALID_XML:
					throw new StreamError('Invalid boolean');
					break;
				case INVALID_OBJECT:
					throw new StreamError('Invalid boolean');
					break;
				default:
					throw new ArgumentError('Given argument is Unknown');
			}
		}
	}
}
