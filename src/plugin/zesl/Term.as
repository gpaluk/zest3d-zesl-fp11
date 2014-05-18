package plugin.zesl 
{
	import plugin.zesl.nodes.ExpressionNode;
	import plugin.zesl.nodes.IExpressionNode;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Term 
	{
		
		public var positive:Boolean;
		public var expression:IExpressionNode;
		
		public function Term( positive:Boolean, expression:IExpressionNode ) 
		{
			this.positive = positive;
			this.expression = expression;
		}
		
	}

}