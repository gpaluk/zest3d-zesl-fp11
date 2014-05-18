package zest3d.zesl 
{
	import zest3d.zesl.nodes.ExpressionNode;
	import zest3d.zesl.nodes.IExpressionNode;
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