package;

/**
 * ...
 * @author lagemanngui
 */
class Estado
{
	
	private var nome:String;
	private var final:Bool;
	private var token:Int = 99;
	
	public var transicoes:Array<Transicao> = [];
	public var devolve:Bool = false;
	

	/**
	 * 
	 * @param	nome O nome do estado, útil para o log
	 * @param	_final Se o estado é final ou não, se o estado for final é necessário
	 * que haja pelo menos um token retornado.
	 */
	public function new(?nome:String, _final:Bool=false) 
	{
		this.nome = nome;
		this.final = _final;
	}
	public function addTransicao(simbolo:Dynamic, destino:Estado):Void
	{
		if (Std.is(simbolo, Array))
		{
			for (i in 0...simbolo.length)
			{
				transicoes.push(new Transicao(simbolo[i], destino));
			}
		}
		else 
		{
			transicoes.push(new Transicao(simbolo, destino));
		}
	}
	public function addToken(token:Int):Void
	{
		this.token = token;
	}
	public function getToken():Int
	{
		return token;
	}

	public function getFinal():Bool
	{
		return final;
	}
	public function getNome():String
	{
		return nome;
	}
}