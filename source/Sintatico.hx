package;

import flixel.FlxG;
/**
 * ...
 * @author lagemanngui
 */
class Sintatico
{
	private var lexico:Lexico;
	private var currToken:Int;
	private var _erro:String = "Nenhum erro sintatico";
	public var pState:ProgramState;
	
	public var erros:Array<String> =
	[
	"Esperava número, variável ou valor lógico",
	"Esperava quebra de linha",
	"Erro na declaração do if",
	"Esperava string, variável ou uma expressão",
	"Erro na declaração do io.write()",
	"Esperava vírgula ou atribuição",
	"Esperava io.read() ou expressão \nOu expressão inválida",
	"Expressão Relacional inválida"
	];
	
	

	public function new(_lex:Lexico, _pstate:ProgramState) 
	{
		lexico = _lex;
		pState = _pstate;
	}
	public function start():Void
	{
		getProximoToken();
		Prog();
		
	}
	/**
	 * Definição das variaveis da gramatica em funções
	 */
	public function getProximoToken():Void
	{
		currToken = lexico.le_token();
	}
	public function Prog():Bool
	{
		
		if (Com())
		{
			return true;
		}
		else if (currToken == Automato.EEOF)
		{
			return true;
		}
		
		/**
		 * Para o erro léxico não sobrepor o sintático
		 */
		if (lexico.foundErro == 0)
		{
			pState.mostraErro("[ERRO SINTÁTICO]\n" + _erro + "\n" + "Linha: " + lexico.getLinha() + 
			" Coluna: " + lexico.getColuna());
			
			var erro:ErroGfx = new ErroGfx(0, 0);
			erro.x = 7 + ((lexico.getColuna()) * 5);
			erro.y = 44 + (lexico.getLinha() * 16);
			FlxG.state.add(erro);
		}
		
		return false;
	}
	public function Com():Bool
	{
		
		if (currToken == Automato.VAR)
		{
			getProximoToken();
			
			if (V())
			{
				if (Delim())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.LOCAL)
		{
			getProximoToken();
			
			if (currToken == Automato.VAR)
			{
				getProximoToken();
				
				if (V())
				{
					if (Delim())
					{
						return true;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		else if (Escrever())
		{
			if (Delim())
			{
				return true;
			}
			else return false;
		}
		else if (Cond())
		{
			if (Delim())
			{
				return true;
			}
			else return false;
		}
		
		_erro = erros[6];
		
		return false;
		
	}
	public function V():Bool
	{
		if (currToken == Automato.ATT)
		{
			getProximoToken();
			
			if (C())
			{
				return true;
			}
			else return false;
		}
		else if (Az())
		{
			return true;
		}
		else return false;
		
		return false;
	}
	public function C():Bool
	{
		if ( currToken == Automato.IO_READ)
		{
			getProximoToken();
			
			return true;
		}
		else if (Atrib())
		{
			return true;
		}
		
		_erro = erros[6];
		
		return false;
	}
	public function H():Bool
	{
		
		if (Atrib())
		{
			return true;
		}
		
		//VAZIO
		return true;
	}
	public function Az():Bool
	{
		if (currToken == Automato.VIRGULA)
		{
			getProximoToken();
			
			if (currToken == Automato.VAR)
			{
				getProximoToken();
				
				if (Ab())
				{
					if (Atrib())
					{
						if (currToken == Automato.VIRGULA)
						{
							getProximoToken();
							
							if (Atrib())
							{
								return true;
							}
							else return false;
						}
						else return false;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		
		//VAZIO
		return true;
	}
	public function Ab():Bool
	{
		if (currToken == Automato.VIRGULA)
		{
			getProximoToken();
			
			if (currToken == Automato.VAR)
			{
				getProximoToken();
				
				if (Ab())
				{
					if (Atrib())
					{
						if (currToken == Automato.VIRGULA)
						{
							getProximoToken();
							
							return true;
						}
						else return false;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.ATT)
		{
			getProximoToken();
			
			return true;
		}
		
		_erro = erros[5];
		
		return false;
	}
	public function Delim():Bool
	{
		if (currToken == Automato.QUEBRA_LINHA)
		{
			
			getProximoToken();
			
			if (R())
			{
				return true;
			}
			else 
			{
				_erro = "Expressão inválida";
				return false;
			}
			
		}
		
		_erro = erros[1] + "\nOu expressão inválida";
		
		return false;
	}
	public function Escrever():Bool
	{	
		if (currToken == Automato.IO_WRITE)
		{
			getProximoToken();
			
			if (currToken == Automato.ABRE_PAREN)
			{
				getProximoToken();
				
				if (S())
				{
					if (currToken == Automato.FECHA_PAREN)
					{
						getProximoToken();
						
						return true;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		
		_erro = erros[4];
		
		return false;
	}
	public function Cond():Bool
	{
		
		if (currToken == Automato.IF)
		{
			getProximoToken();
			
			if (E1())
			{
				if (currToken == Automato.ABRE_CHAVE)
				{
					getProximoToken();
					
					if (Delim())
					{
						if (currToken == Automato.FECHA_CHAVE)
						{
							getProximoToken();
							
							if (Delim2())
							{
								if (Cond2())
								{
									return true;
								}
								else return false;
							}
							else return false;
						}
						else return false;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		
		
		_erro = erros[2];
		
		return false;
	}
	public function Decl():Bool
	{
		
		if (currToken == Automato.VIRGULA)
		{
			getProximoToken();
			
			if (currToken == Automato.VAR)
			{
				getProximoToken();
				
				if (Decl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.ATT)
		{
			getProximoToken();
			
			if (Atrib())
			{
				if (F())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		
		return false;
	}
	public function F():Bool
	{
		
		if (currToken == Automato.VIRGULA)
		{
			getProximoToken();
			
			if (Atrib())
			{
				if (F())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		return false;
	}
	public function Delim2():Bool
	{
		if (currToken == Automato.QUEBRA_LINHA)
		{
			getProximoToken();
			
			if (G())
			{
				return true;
			}
			else return false;
		}
		
		
		_erro = erros[1];
		
		return false;
	}
	public function G():Bool
	{
		if (Delim2())
		{
			return true;
		}
		
		//VAZIO
		return true;
	}
	public function Cond2():Bool
	{
		if (currToken == Automato.ELSE)
		{
			getProximoToken();
			
			if (currToken == Automato.ABRE_CHAVE)
			{
				getProximoToken();
				
				if (Delim())
				{
					if (currToken == Automato.FECHA_CHAVE)
					{
						getProximoToken();
						
						return true;
					}
					else return false;
				}
				else return false;
			}
			else return false;
		}
		
		//VAZIO
		return true;
	}
	public function Atrib():Bool
	{
		if (E1())
		{
			return true;
		}
		return false;
	}
	
	public function E1():Bool
	{
		if (E2())
		{
			if (Zl())
			{
				return true;
			}
			else return false;
		}
		
		_erro = "Erro no E4";

		
		return false;
	}
	public function Z():Bool
	{
		
		if (currToken == Automato.LOG_OR)
		{
			getProximoToken();
			
			if (E2())
			{
				if (Zl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		return false;
	}
	public function Zl():Bool
	{
		if (Z())
		{
			return true;
		}
		
		return true;
	}
	public function E2():Bool
	{
		if (E3())
		{
			if (Wl())
			{
				return true;
			}
			else return false;
		}
		
		_erro = "Erro no E2";
		
		return false;
	}
	public function W():Bool
	{
		if (currToken == Automato.LOG_AND)
		{
			getProximoToken();
			
			if (E3())
			{
				if (Wl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		return false;
	}
	public function Wl():Bool
	{
		if (W())
		{
			return true;
		}
		
		return true;
	}
	public function E3():Bool
	{
		if (currToken == Automato.LOG_NOT)
		{
			getProximoToken();
			
			if (E3())
			{
				return true;
			}
			else return false;
		}
		else if (E4())
		{
			return true;
		}
		
		_erro = "Erro no E3";
		
		return false;
	}
	public function E4():Bool
	{
		if (E5())
		{
			if (N())
			{
				return true;
			}
		}
		
		_erro = "Erro no E4";
		
		return false;
	}
	public function N():Bool
	{
		if (currToken == Automato.REL_MAIOR)
		{
			getProximoToken();
			
			if (E5())
			{
				return true;
			}
			else 
			{
				_erro = erros[7];
				return false;
			}
		}
		else if (currToken == Automato.REL_MAIOR_IGUAL)
		{
			getProximoToken();
			
			if (E5())
			{
				return true;
			}
			else 
			{
				_erro = erros[7];
				return false;
			}
		}
		else if (currToken == Automato.REL_MENOR)
		{
			getProximoToken();
			
			if (E5())
			{
				return true;
			}
			else 
			{
				_erro = erros[7];
				return false;
			}
		}
		else if (currToken == Automato.REL_MENOR_IGUAL)
		{
			getProximoToken();
			
			if (E5())
			{
				return true;
			}
			else 
			{
				_erro = erros[7];
				return false;
			}
		}
		else if (currToken == Automato.REL_IGUAL)
		{
			getProximoToken();
			
			if (E5())
			{
				return true;
			}
			else 
			{
				_erro = erros[7];
				return false;
			}
		}
		
		//VAZIO
		return true;
	}
	public function R():Bool
	{
		if (Com())
		{
			return true;
		}
		else if (Delim())
		{
			return true;
		}
		
		
		return true;
	}
	public function S():Bool
	{
		if (currToken == Automato.SSTRING)
		{
			getProximoToken();
			
			if (T())
			{
				return true;
			}
			else return false;
		}
		else if (currToken == Automato.VAR)
		{
			getProximoToken();
			
			if (T())
			{
				return true;
			}
			else return false;
		}
		else if (Atrib())
		{
			if (T())
			{
				return true;
			}
			else return false;
		}
		
		_erro = erros[3];
		
		return false;
	}
	public function T():Bool
	{
		if (currToken == Automato.VIRGULA)
		{
			getProximoToken();
			
			if (S())
			{
				return true;
			}
			else return false;
		}
		
		//VAZIO
		return true;
		
	}
	public function E5():Bool
	{
		if (E6())
		{
			
			if (Yl())
			{
				return true;
			}
		}
		
		_erro = "Erro no E5";
		
		return false;
	}
	public function Yl():Bool
	{
		if (Y())
		{
			return true;
		}
		
		//VAZIO
		return true;
		
	}
	public function Y():Bool
	{
		if (currToken == Automato.SOMA)
		{
			getProximoToken();
			
			if (E6())
			{
				if (Yl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.SUBT)
		{
			getProximoToken();
			
			if (E6())
			{
				if (Yl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		_erro = "Erro no Y";
		
		return false;
	}
	public function E6():Bool
	{
		if (E7())
		{
			if (Xl())
			{
				return true;
			}
			else return false;
		}
		
		_erro = "Erro no E6";
		
		return false;
	}
	public function X():Bool
	{
		if (currToken == Automato.MULT)
		{
			getProximoToken();
			
			if (E7())
			{
				if (Xl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.DIVI)
		{
			getProximoToken();
			
			if (E7())
			{
				if (Xl())
				{
					return true;
				}
				else return false;
			}
			else return false;
		}
		
		_erro = "Erro no X";
		
		return false;
	}
	public function Xl():Bool
	{
		if (X())
		{
			return true;
		}
		
		return true;
	}
	public function E7():Bool
	{
		if (E8())
		{
			if (K())
			{
				return true;
			}
		}
		
		_erro = "Erro no E7";
		
		
		return false;
	}
	public function K():Bool
	{
		if (currToken == Automato.POT)
		{
			getProximoToken();
			
			if (E7())
			{
				return true;
			}
			else return false;
		}
		
		//VAZIO
		return true;
	}
	public function E8():Bool
	{
		if (currToken == Automato.SUBT)
		{
			getProximoToken();
			
			if (E8())
			{
				return true;
			}
			else return false;
		}
		else if (B())
		{
			return true;
		}
		
		_erro = "Erro no E8";
		
		return false;
	}
	public function B():Bool
	{
		if (currToken == Automato.NUM)
		{
			getProximoToken();
			
			return true;
		}
		else if ( currToken == Automato.ABRE_PAREN)
		{
			getProximoToken();
			
			if (E1())
			{
				if (currToken == Automato.FECHA_PAREN)
				{
					getProximoToken();
					
					return true;
				}
				else return false;
			}
			else return false;
		}
		else if (currToken == Automato.VAR)
		{
			getProximoToken();
			
			return true;
			
		}
		else if (currToken == Automato.VALOR_LOGICO)
		{
			getProximoToken();
			
			return true;
		}
		
		_erro = erros[0];
		
		return false;
	}
	
	/**
	 * Funcao de debug
	 */
	public function printToken():Void
	{
		trace(TokenMap.tokenMap.get(currToken));
	}
}
