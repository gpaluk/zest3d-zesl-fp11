package plugin.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class FunctionExpressionNode extends ExpressionNode implements IExpressionNode
	{
		
		public static const SIN:int = 1;
		public static const COS:int = 2;
		public static const TAN:int = 3;
		
		public static const ASIN:int = 4;
		public static const ACOS:int = 5;
		public static const ATAN:int = 6;
		
		public static const SQRT:int = 7;
		public static const EXP:int = 8;
		
		public static const LN:int = 9;
		public static const LOG:int = 10;
		public static const LOG2:int = 11;
		
		private var _function:int;
		private var _argument:IExpressionNode;
		
		public function FunctionExpressionNode( func:int, arg:IExpressionNode ) 
		{
			_function = func;
			_argument = arg;
		}
		
		override public function get type():int
		{
			return ExpressionNode.FUNCTION_NODE;
		}
		
		override public function get value():Number
		{
			switch( _function )
			{
				case SIN: return Math.sin( _argument.value );
				case COS: return Math.cos( _argument.value );
				case TAN: return Math.tan( _argument.value );
				case ASIN: return Math.asin( _argument.value );
				case ACOS: return Math.acos( _argument.value );
				case ATAN: return Math.atan( _argument.value );
				case SQRT: return Math.sqrt( _argument.value );
				case EXP: return Math.exp( _argument.value );
				case LN: return Math.log( _argument.value );
				case LOG: return Math.log( _argument.value ) * 0.43429448190325182765;
				case LOG2: return Math.log( _argument.value ) * 1.442695040888963407360;
			}
			throw new Error( "Invalid function id " + _function + "." )
		}
		
		public static function stringToFunction( str:String ):int
		{
			switch( str )
			{
				case "sin": return FunctionExpressionNode.SIN;
				case "cos": return FunctionExpressionNode.COS;
				case "tan": return FunctionExpressionNode.TAN;
				case "asin": return FunctionExpressionNode.ASIN;
				case "acos": return FunctionExpressionNode.ACOS;
				case "atan": return FunctionExpressionNode.ATAN;
				case "sqrt": return FunctionExpressionNode.SQRT;
				case "exp": return FunctionExpressionNode.EXP;
				case "ln": return FunctionExpressionNode.LN;
				case "log": return FunctionExpressionNode.LOG;
				case "log2": return FunctionExpressionNode.LOG2;
			}
			throw new Error( "Unexpected Function " + str + "." );
		}
		
		public static function getAllFunctions(): String
		{
			return "sin|cos|tan|asin|acos|atan|sqrt|exp|ln|log|log2";
		}
		
		override public function accept(visitor:IExpressionNodeVisitor):void 
		{
			visitor.visit(this);
			_argument.accept(visitor);
		}
	}

}