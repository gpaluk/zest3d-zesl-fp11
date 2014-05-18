package plugin.zesl.nodes 
{
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public interface IExpressionNodeVisitor 
	{
		function visit( node: IExpressionNode ):void;
	}

}