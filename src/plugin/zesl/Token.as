package plugin.zesl 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Token 
	{
		
		public static const EPSILON: int = 0;
		public static const PLUSMINUS: int = 1;
		public static const MULTDIV: int = 2;
		public static const RAISED:int = 3;
		public static const FUNCTION:int = 4;
		public static const OPEN_BRACKET:int = 5;
		public static const CLOSE_BRACKET:int = 6;
		public static const NUMBER:int = 7;
		public static const VARIABLE:int = 8;
		
		public var token:int;
		public var sequence:String;
		public var pos:int;
		
		public function Token( token:int, sequence:String, pos:int ) 
		{
			this.token = token;
			this.sequence = sequence;
			this.pos = pos;
		}
		
	}

}