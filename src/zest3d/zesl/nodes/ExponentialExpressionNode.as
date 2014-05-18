package zest3d.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ExponentialExpressionNode extends ExpressionNode implements IExpressionNode
	{
		
		private var _base:IExpressionNode;
		private var _exponent:IExpressionNode;
		
		public function ExponentialExpressionNode( base:IExpressionNode, exponent:IExpressionNode ) 
		{
			_base = base;
			_exponent = exponent;
		}
		
		override public function get type():int
		{
			return ExpressionNode.EXPONENTIATION_NODE;
		}
		
		override public function get value():Number
		{
			return Math.pow( _base.value, _exponent.value );
		}
		
		override public function accept(visitor:IExpressionNodeVisitor):void 
		{
			visitor.visit( this );
			super.accept( visitor );
			_exponent.accept( visitor );
		}
	}

}