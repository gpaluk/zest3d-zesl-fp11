package plugin.zesl.nodes 
{
	import plugin.zesl.Term;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class MultiplicationExpressionNode extends SequenceExpressionNode 
	{
		
		public function MultiplicationExpressionNode( expression:IExpressionNode = null, positive:Boolean = true ) 
		{
			super( expression, positive );
		}
		
		override public function get type():int
		{
			return ExpressionNode.MULTIPLICATION_NODE;
		}
		
		override public function get value():Number
		{
			var prod:Number = 1;
			
			for each( var term:Term in _terms )
			{
				if ( term.positive )
				{
					prod *= term.expression.value;
				}
				else
				{
					prod /= term.expression.value;
				}
			}
			return prod;
		}
		
		override public function accept(visitor:IExpressionNodeVisitor):void 
		{
			visitor.visit(this);
			for each( var term:Term in _terms )
			{
				term.expression.accept( visitor );
			}
		}
		
	}

}