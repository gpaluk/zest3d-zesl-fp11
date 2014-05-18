package plugin.zesl 
{
	import plugin.zesl.nodes.FunctionExpressionNode;
	import io.plugin.utils.StringUtils;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Tokenizer 
	{
		
		private var _tokenInfos:Vector.<TokenInfo>;
		private var _tokens:Vector.<Token>;
		private static var _instance:Tokenizer = null;
		
		public function Tokenizer() 
		{
			_tokenInfos = new Vector.<TokenInfo>();
			_tokens = new Vector.<Token>();
		}
		
		public static function getInstance():Tokenizer
		{
			if ( !_instance )
			{
				_instance = createExpressionTokenizer();
			}
			return _instance;
		}
		
		public function add( regex:String, token:int ):void
		{
			var exp:RegExp = new RegExp();
			_tokenInfos.push( new TokenInfo( new RegExp( "^" + regex ), token ));
		}
		
		private static function createExpressionTokenizer():Tokenizer
		{
			var tokenizer:Tokenizer = new Tokenizer();
			tokenizer.add( "[+-]", Token.PLUSMINUS );
			tokenizer.add( "[*/]", Token.MULTDIV );
			tokenizer.add( "[\\^]", Token.RAISED );
			
			var funcs:String = FunctionExpressionNode.getAllFunctions();
			tokenizer.add( "(" + funcs + ")(?!\\w)", Token.FUNCTION );
			
			tokenizer.add( "\\(", Token.OPEN_BRACKET );
			tokenizer.add( "\\)", Token.CLOSE_BRACKET );
			tokenizer.add( "(?:\\d+\\.?|\\.\\d)\\d*(?:[Ee][-+]?\\d+)?", Token.NUMBER );
			tokenizer.add( "[a-zA-Z]\\w*", Token.VARIABLE );
			
			return tokenizer;
		}
		
		public function tokenize( str:String ):void
		{
			var s:String = StringUtils.trim( str );
			var totalLength:int = s.length;
			_tokens.length = 0;
			
			while ( s != "" )
			{
				var remaining:int = s.length;
				var match:Boolean = false;
				
				for each( var info:TokenInfo in _tokenInfos )
				{
					var tokenStr:Array =  s.match( info.regex );
					
					if ( tokenStr )
					{
						match = true;
						
						tokens.push( new Token( info.token, tokenStr[0], totalLength - remaining ));
						s = s.substr( tokenStr[0].length, s.length );
						s = StringUtils.trim( s );
					}
				}
				
				if ( !match )
				{
					throw new Error( "Unexpected character in input: " + s );
				}
			}
		}
		
		public function get tokens():Vector.<Token> 
		{
			return _tokens;
		}
		
	}

}

internal class TokenInfo
{
	public var regex:RegExp;
	public var token:int;
	
	public function TokenInfo( regex:RegExp, token:int )
	{
		this.regex = regex;
		this.token = token;
	}
}