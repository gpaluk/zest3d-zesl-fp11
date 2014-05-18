package zest3d.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ConstantExpressionNode implements IExpressionNode 
	{
		
		private var _value:Number;
		
		public function ConstantExpressionNode(value:Number) 
		{
			_value = value;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function get type():int 
		{
			return ExpressionNode.CONSTANT_NODE;
		}
		
		public function accept(visitor:IExpressionNodeVisitor):void 
		{
			visitor.visit(this);
		}
	}

}