package zest3d.zesl 
{
	import zest3d.zesl.nodes.AdditionExpressionNode;
	import zest3d.zesl.nodes.ConstantExpressionNode;
	import zest3d.zesl.nodes.ExponentialExpressionNode;
	import zest3d.zesl.nodes.ExpressionNode;
	import zest3d.zesl.nodes.FunctionExpressionNode;
	import zest3d.zesl.nodes.IExpressionNode;
	import zest3d.zesl.nodes.MultiplicationExpressionNode;
	import zest3d.zesl.nodes.VariableExpressionNode;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Parser 
	{
		
		private var _tokens:Vector.<Token>;
		private var _lookahead:Token;
		
		public function Parser() 
		{
			
		}
		
		private function cloneTokens( tokens:Vector.<Token>):Vector.<Token>
		{
			var clone:Vector.<Token> = new Vector.<Token>();
			
			for each( var token:Token in tokens )
			{
				clone.push( new Token( token.token, token.sequence, token.pos ) );
			}
			
			return clone;
		}
		
		public function parse( program:String ):IExpressionNode
		{
			var tokenizer:Tokenizer = Tokenizer.getInstance();
			tokenizer.tokenize( program );
			var tokens:Vector.<Token> = tokenizer.tokens;
			return parseTokens( tokens );
		}
		
		public function parseTokens( tokens:Vector.<Token> ):IExpressionNode
		{
			_tokens = cloneTokens( tokens );
			_lookahead = _tokens[0];
			return expression();
		}
		
		private function nextToken():void
		{
			_tokens.shift();
			
			if ( _tokens.length == 0 )
			{
				_lookahead = new Token( Token.EPSILON, "", -1 );
			}
			else
			{
				_lookahead = _tokens[0];
			}
		}
		
		private function expression():IExpressionNode
		{
			var expr:IExpressionNode = signedTerm();
			expr = sumOp( expr );
			return expr;
		}
		
		private function sumOp( expr:IExpressionNode ):IExpressionNode
		{
			if ( _lookahead.token == Token.PLUSMINUS )
			{
				var sum:AdditionExpressionNode;
				
				if ( expr.type == ExpressionNode.ADDITION_NODE )
				{
					sum = expr as AdditionExpressionNode;
				}
				else
				{
					sum = new AdditionExpressionNode( expr, true );
				}
				
				var positive:Boolean = _lookahead.sequence == "+";
				nextToken();
				
				var t:IExpressionNode = term();
				sum.add( t, positive );
				
				return sumOp( sum );
			}
			return expr;
		}
		
		private function signedTerm():IExpressionNode
		{
			if ( _lookahead.token == Token.PLUSMINUS )
			{
				var positive:Boolean = _lookahead.sequence == "+";
				nextToken();
				var t:IExpressionNode = term();
				if ( positive )
				{
					return t;
				}
				else
				{
					return new AdditionExpressionNode( t, false );
				}
			}
			return term();
		}
		
		private function term():IExpressionNode
		{
			var f:IExpressionNode = factor();
			return termOp(f);
		}
		
		private function termOp(expression:IExpressionNode):IExpressionNode
		{
			if ( _lookahead.token == Token.MULTDIV )
			{
				var prod:MultiplicationExpressionNode;
				
				if (expression.type == ExpressionNode.MULTIPLICATION_NODE )
				{
					prod = expression as MultiplicationExpressionNode;
				}
				else
				{
					prod = new MultiplicationExpressionNode( expression, true );
				}
				
				var positive:Boolean = _lookahead.sequence == "*";
				nextToken();
				
				var f:IExpressionNode = factor();
				prod.add( f, positive );
				
				return termOp(prod);
			}
			return expression;
		}
		
		private function factor():IExpressionNode
		{
			if ( _lookahead.token == Token.FUNCTION )
			{
				var func:int = FunctionExpressionNode.stringToFunction( _lookahead.sequence );
				if ( func < 0 )
				{
					throw new Error( "Unexpected Function " + _lookahead.sequence + " found." );
				}
				nextToken();
				var expr:IExpressionNode = factor();
				return new FunctionExpressionNode( func, expr );
			}
			
			var arg:IExpressionNode = argument();
			return factorOp( arg );
		}
		
		private function factorOp( expr:IExpressionNode ): IExpressionNode
		{
			if ( _lookahead.token == Token.RAISED )
			{
				nextToken();
				var exponent:IExpressionNode = factor();
				return new ExponentialExpressionNode( expr, exponent );
			}
			return expr;
		}
		
		private function argument():IExpressionNode
		{
			if ( _lookahead.token == Token.OPEN_BRACKET )
			{
				nextToken();
				var expr:IExpressionNode = expression();
				
				if ( _lookahead.token != Token.CLOSE_BRACKET )
				{
					throw new Error( "Closing brackets expected and " + _lookahead.sequence + " found instead." );
				}
				
				nextToken();
				return expr;
			}
			return value();
		}
		
		private function value():IExpressionNode
		{
			var expr:IExpressionNode;
			if ( _lookahead.token == Token.NUMBER )
			{
				expr = new ConstantExpressionNode( Number(_lookahead.sequence) );
				nextToken();
				return expr;
			}
			
			if ( _lookahead.token == Token.VARIABLE )
			{
				expr = new VariableExpressionNode( _lookahead.sequence );
				nextToken();
				return expr;
			}
			
			if ( _lookahead.token == Token.EPSILON )
			{
				throw new Error( "Unexpected end of input" );
			}
			else
			{
				throw new Error( "Unexpected symbol " + _lookahead.sequence + " found." );
			}
		}
		
	}

}