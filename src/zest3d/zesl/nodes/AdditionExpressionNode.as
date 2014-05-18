package zest3d.zesl.nodes 
{
	import zest3d.zesl.Term;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class AdditionExpressionNode extends SequenceExpressionNode 
	{
		
		public function AdditionExpressionNode( expression:IExpressionNode = null, positive:Boolean = true ) 
		{
			super( expression, positive );
		}
		
		override public function get type():int
		{
			return ExpressionNode.ADDITION_NODE;
		}
		
		override public function get value():Number
		{
			var sum:Number = 0;
			
			for each( var term:Term in _terms )
			{
				if ( term.positive )
				{
					sum += term.expression.value;
				}
				else
				{
					sum -= term.expression.value;
				}
			}
			return sum;
		}
		
		override public function accept( visitor:IExpressionNodeVisitor ):void
		{
			visitor.visit( this );
			
			for each( var term:Term in _terms )
			{
				term.expression.accept( visitor );
			}
		}
	}

}