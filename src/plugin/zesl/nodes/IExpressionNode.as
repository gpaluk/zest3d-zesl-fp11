package plugin.zesl.nodes 
{
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public interface IExpressionNode 
	{
		function get type():int;
		function get value():Number;
		function accept( visitor:IExpressionNodeVisitor ):void;
	}
	
}