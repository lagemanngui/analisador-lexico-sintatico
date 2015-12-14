package;

/**
 * ...
 * @author lagemanngui
 */
class Reg
{
	public static var CURRENT_FILE:String = "default.txt";
	
	//Simbolos
	public static var LETRAS:Array<String> = 
	[
	"a", "b", "c", "d", "e", "f", "g", "h", "i",
	"j", "k", "l", "m", "n", "o", "p", "q", "r",
	"s", "t", "u", "v", "x", "z", "w", "y", "ç"];
	
	public static var NUMEROS:Array<String> = 
	["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
	
	public static var UNDERLINE:String = "_";
	
	public static var OPERADORES_ARITMETICOS:Array<String> =
	["+", "-", "*", "/", "**"];
	
	public static var OPERADORES_RELACIONAIS:Array<String> = 
	["<", ">", "<=", ">=", "=="];
	
	public static var OPERADORES_LOGICOS:Array<String> =
	["!", "|", "&"];
	
	public static var LOGICOS:Array<String> = 
	["true", "false", "nil"];
	
	public static var ESPECIAIS:Array<String> =
	["(", ")", "{", "}"];
	
	public static var QUEBRALINHA:String = "\r";
	public static var QUEBRALINHA2:String = "\n";
	
	public static var ESPACO:String = " ";
	
	
	/**
	 * Combinações de simbolos
	**/
	//Todos menos LETRAS, NUMEROS, UNDERLINE
	public static var OUTRO_1:Array<Dynamic> = [];

	
	//Palavras reservadas (sem o io.write e o io.read)
	public static inline var IF:String = "if";
	public static inline var ELSE:String = "else";
	public static inline var LOCAL:String = "local";
	public static inline var TRUE:String = "true";
	public static inline var FALSE:String = "false";
	public static inline var NIL:String = "nil";
	
	//Outros
	public static var TOKENS_LIDOS:Array<Int> = [];
	
	
}