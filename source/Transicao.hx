package;

/**
 * ...
 * @author lagemanngui
 */
class Transicao
{
	private var simbolo:Dynamic;
	private var destino:Estado;

	public function new(simbolo:Dynamic, destino:Estado) 
	{
		this.simbolo = simbolo;
		this.destino = destino;
	}
	public function getSimbolo():Dynamic
	{
		return simbolo;
	}
	public function getDestino():Estado
	{
		return destino;
	}
	
}