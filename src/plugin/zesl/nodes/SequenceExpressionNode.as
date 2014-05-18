package plugin.zesl.nodes 
{
	import plugin.zesl.Term;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class SequenceExpressionNode extends ExpressionNode implements IExpressionNode
	{
		
		protected var _terms:Vector.<Term>;
		
		public function SequenceExpressionNode(expression:IExpressionNode = null, positive:Boolean = true ) 
		{
			// TODO enforce abstract class
			_terms = new Vector.<Term>();
			if ( expression )
			{
				_terms.push( new Term( positive, expression ));
			}
		}
		
		public function add( expression:IExpressionNode, positive:Boolean = true ):void
		{
			_terms.push( new Term( positive, expression ) );
		}
		
	}

}