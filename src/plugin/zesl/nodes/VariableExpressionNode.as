package plugin.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class VariableExpressionNode implements IExpressionNode 
	{
		
		private var _name:String;
		private var _value:Number;
		private var _valueSet:Boolean;
		
		public function VariableExpressionNode( name:String ) 
		{
			_name = name;
			_valueSet = false;
		}
		
		public function get type():int 
		{
			return ExpressionNode.VARIABLE_NODE;
		}
		
		public function set value( value:Number ):void
		{
			this._value = value;
			this._valueSet = true;
		}
		
		public function get value():Number 
		{
			if ( _valueSet )
			{
				return _value;
			}
			throw new Error( "Variable '" + _name + "' was not initialized." );
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function accept( visitor:IExpressionNodeVisitor ):void
		{
			visitor.visit( this );
		}
	}

}