package zest3d.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class SetVariable implements IExpressionNodeVisitor 
	{
		
		private var _name:String;
		private var _value:Number;
		
		public function SetVariable( name:String, value:Number ) 
		{
			_name = name;
			_value = value;
		}
		
		public function visit(node:IExpressionNode):void 
		{
			var ven:VariableExpressionNode = node as VariableExpressionNode;
			
			if ( ven )
			{
				if ( ven.name == _name )
				{
					ven.value = _value;
				}
			}
		}
		
	}

}