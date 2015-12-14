package;

/**
 * ...
 * @author lagemanngui
 */
class TokenMap
{
	public static var tokenMap:Map<Int,String>;

	public static function init() 
	{
		tokenMap = 
		[ 
		Automato.VAR => "VAR",
		Automato.IF => "IF",
		Automato.ELSE =>  "ELSE",
		Automato.LOCAL =>  "LOCAL",
		Automato.IO_WRITE =>  "IO_WRITE",
		Automato.IO_READ => "IO_READ",
		Automato.ATT => "ATT",
		Automato.VIRGULA => "VIRGULA",
		Automato.SOMA => "SOMA",
		Automato.SUBT => "SUBT",
		Automato.MULT => "MULT",
		Automato.DIVI => "DIVI",
		Automato.POT => "POT",
		Automato.SSTRING => "STRING",
		Automato.QUEBRA_LINHA => "QUEBRA_LINHA",
		Automato.ABRE_CHAVE => "ABRE_CHAVE",
		Automato.FECHA_CHAVE => "FECHA_CHAVE",
		Automato.ABRE_PAREN => "ABRE_PAREN",
		Automato.FECHA_PAREN => "FECHA_PAREN",
		Automato.NUM => "NUM",
		Automato.VALOR_LOGICO => "VALOR_LOGICO",
		Automato.LOG_AND => "LOG_AND",
		Automato.LOG_OR => "LOG_OR",
		Automato.LOG_NOT => "LOG_NOT",
		Automato.REL_MAIOR => "REL_MAIOR",
		Automato.REL_MAIOR_IGUAL => "REL_MAIOR_IGUAL",
		Automato.REL_MENOR => "REL_MENOR",
		Automato.REL_MENOR_IGUAL => "REL_MENOR_IGUAL",
		Automato.REL_IGUAL => "REL_IGUAL",
		Automato.EEOF => "EEOF"
		];
		
	}
	
}