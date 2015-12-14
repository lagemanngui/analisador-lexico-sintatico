package;
import flixel.FlxG;
import sys.io.File;
import haxe.io.Eof;


/**
 * ...
 * @author lagemanngui
 */
class Lexico
{
	private var linha:Int = 1;
	private var coluna:Int = 1;
	private var estadoAtual:Estado;
	private var lendo:String = "";
	private var entrada:String;
	
	public var automato:Automato;
	public var currIndex:Int = 0;
	public var currChar:String = "";
	public var utlimoFinal:Estado;
	
	//Instacia principal do programa
	public var programState:ProgramState;
	public var currentError:String = "Nenhum erro encontrado.";
	
	public var foundErro:Int = 0;

	public function new(_automato:Automato, _entrada:String, _pstate:ProgramState) 
	{
		programState = _pstate;
		automato = _automato;
		entrada = _entrada;
		estadoAtual = _automato.q0;
	}
	
	public function getEstado():Estado
	{
		return estadoAtual;
	}
	
	public function getUltimoFinal():Estado
	{
		return utlimoFinal;
	}
	public function le_token():Int
	{
		
		//Char que está sendo lido agora
		currChar = entrada.charAt(currIndex);
		
		
		/**
		 * Atualiza buffer
		 */
		updateBuffer();
		
		
		
		//Verifica se o caratere é valido para o estado
		if (transicaoValida(currChar))
		{
			
			/**
			 * Verifica se é uma nova linha atraves do ultimo estado
			 * pra contar as posições nas linhas x colunas
			 */
			if (estadoAtual.getNome() == "q6")
			{
				linha++;
				coluna = 1;
			}else
			{
				//Incrementa a posição na coluna
				if (estadoAtual.devolve == false)
				{
					coluna++;
				}
			}
			
			//Se o estado for final retorna o token, senão continua lendo
			if (estadoAtual.getFinal())
			{	
				
				var tk = retornaToken();
				resetLex();
				return tk;
				
			}
		}else
		{
			/**
			 * Verifica se é fim de arquivo 
			 */
			if (StringTools.isEof(StringTools.fastCodeAt(currChar, 0)))
			{
				programState.mostraErro("[Nenhum Erro]\nFim de arquivo");
				
				return retornaToken(Automato.EEOF);
				
			}
			//Se não for, retorna o erro o lexico
			else
			{
				foundErro = 1;
				
				programState.mostraErro("[ERRO LEXICO]\nSequencia invalida:\n \"" 
				+ lendo + "\"\nLinha: " + linha + " Coluna: " + coluna);
				
				var erro:ErroGfx = new ErroGfx(0, 0);
				erro.x = 7 + ((coluna) * 5);
				erro.y = 44 + (linha * 16);
				
				FlxG.state.add(erro);
				
				return -999;
			}
		}
		
		//Se o estado não for final continua lendo
		if(estadoAtual.devolve==false) currIndex++;
		return le_token();
		
		
	
		
		
		
	}
	/**
	 * Descobre se o caractere pode ser lido naquele estado, ou seja
	 * se o caratecre está na lista de transição
	 * @param	char O caractere a ser lido
	 * @return Retorna falso se o caratere não faz parte das transições possiveis.
	 * Retorna true caso contrário.
	 */
	public function transicaoValida(char):Bool
	{
		if (char == null) return false;
		
		//Procura o simbolo na lista de transição do estado
		for (i in 0...estadoAtual.transicoes.length)
		{
			if (estadoAtual.transicoes[i].getSimbolo() == char)
			{
				
				//Atualiza o estado atual para o estado de destino do simbolo
				estadoAtual = estadoAtual.transicoes[i].getDestino();
				
				
				return true;
			}
		}
		
		return false;
		
	}
	/**
	 * Retorna o token lido
	 * @param	_token Usado apenas para retornar o resultado da função le_palavra()
	 */
	public function retornaToken(?_token:Int):Int
	{
		if (_token != null)
		{
			Reg.TOKENS_LIDOS.push(_token);
			
			return _token;
		}
		
		if (estadoAtual.getToken() == Automato.INDETERMINADO)
		{
			return le_palavra();
			
		}else
		{
			Reg.TOKENS_LIDOS.push(estadoAtual.getToken());
			
			return estadoAtual.getToken();
		}
		
		return 0;
	}
	/**
	 * Função pra ler a palavra reservada e retornar o token adequado
	 */
	public function le_palavra():Int
	{
		if (lendo == Reg.IF)
		{
			return retornaToken(Automato.IF);
		}
		else if (lendo == Reg.ELSE)
		{
			return retornaToken(Automato.ELSE);
		}
		else if (lendo == Reg.LOCAL)
		{
			return retornaToken(Automato.LOCAL);
		}
		else if (lendo == Reg.TRUE)
		{
			return retornaToken(Automato.VALOR_LOGICO);
		}
		else if (lendo == Reg.FALSE)
		{
			return retornaToken(Automato.VALOR_LOGICO);
		}
		else if (lendo == Reg.NIL)
		{
			return retornaToken(Automato.VALOR_LOGICO);
		}
		
		return retornaToken(Automato.VAR);
		
	}
	public function resetLex():Void
	{
		lendo = "";	
		
		if (estadoAtual.devolve == false)
		{
			currIndex++;
		}
		utlimoFinal = estadoAtual;
		estadoAtual = automato.q0;
	}
	public function updateBuffer():Void
	{
		//Se o char sendo lido não for "especial"
		//atualiza o buffer 'lendo'
		if (currChar != " " && currChar != "\r" && currChar != "\n"
			&& currChar != "}" && currChar != "{" && currChar != "("
			&& currChar != ")" && currChar != ",") 
			lendo += currChar;
	}
	public function getLinha():Int
	{
		return linha;
	}
	public function getColuna():Int
	{
		return coluna;
	}
	
}