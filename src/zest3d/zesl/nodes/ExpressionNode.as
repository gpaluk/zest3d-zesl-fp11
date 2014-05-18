package zest3d.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ExpressionNode implements IExpressionNode
	{
		
		public static const VARIABLE_NODE:int = 1;
		public static const CONSTANT_NODE:int = 2;
		public static const ADDITION_NODE:int = 3;
		public static const MULTIPLICATION_NODE:int = 4;
		public static const EXPONENTIATION_NODE:int = 5;
		public static const FUNCTION_NODE:int = 6;
		
		public function get type():int
		{
			throw new Error("type must be overridden.");
		}
		
		public function get value():Number
		{
			throw new Error("value must be overridden.");
		}
		
		public function accept(visitor:IExpressionNodeVisitor):void
		{
		}
	}

}