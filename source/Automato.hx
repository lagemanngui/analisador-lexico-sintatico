package;

/**
 * Nessa classe são definidos os tokens retornados pelo analisador léxico
 * bem como os estados do automato e suas transições.
 * 
 * @author lagemanngui
 */
class Automato
{
	//Tokens
	/**
	 * Quando o token é indeterminado cai no caso de ter
	 * que ler a palavra encontrada pra saber se é uma variavel
	 * ou uma palavra reservada da linguagem
	 */
	public static var INDETERMINADO:Int = -1;
	/**
	 * Token para variaveis em geral (identificadores)
	 */
	public static var VAR:Int = 0;
	
	
	/**
	 * >>>TOKEN PARA PALAVRAS RESERVADAS
	 * Token para palavra reservada if
	 */
	public static var IF:Int = 1;
	/**
	 * Token para palavra reservada else
	 */
	public static var ELSE:Int = 2;
	/**
	 * Token para palavra reservada local
	 */
	public static var LOCAL:Int = 3;
	/**
	 * Token para palabra reservada io.write
	 */
	public static var IO_WRITE:Int = 26;
	public static var IO_READ:Int = 27;
	
	public static var ATT:Int = 28;
	public static var VIRGULA:Int = 29;
	
	
	/**
	 * >>>TOKEN PARA OPERADORES
	 */
	public static var SOMA:Int = 4;
	public static var SUBT:Int = 5;
	public static var MULT:Int = 6;
	public static var DIVI:Int = 7;
	public static var POT:Int = 25;
	//TALVEZ NAO USAR SUBT_UNI
	//public static var SUBT_UNI:Int = 8;
	
	/**
	 * Token para string
	 */
	public static var SSTRING:Int = 9;
	
	/**
	 * Token para quebra de linha
	 */
	public static var QUEBRA_LINHA:Int = 10;
	
	/**
	 * Token parenteses
	 */
	public static var ABRE_PAREN:Int = 11;
	public static var FECHA_PAREN:Int = 12;
	
	/**
	 * Token chaves
	 */
	public static var ABRE_CHAVE:Int = 13;
	public static var FECHA_CHAVE:Int = 14;
	
	/**
	 * Token para valor numerico
	 */
	public static var NUM:Int = 15;
	
	/**
	 * Token para constantes lógicas
	 */
	public static var VALOR_LOGICO:Int = 16;
	
	/**
	 * >>>TOKEN OPERADORES LOGICOS
	 */
	public static var LOG_AND:Int = 17;
	public static var LOG_OR:Int = 18;
	public static var LOG_NOT:Int = 19;
	
	/**
	 * >>>TOKEN RELACIONAIS
	 */
	public static var REL_MAIOR:Int = 20;
	public static var REL_MAIOR_IGUAL:Int = 21;
	public static var REL_MENOR:Int = 22;
	public static var REL_MENOR_IGUAL:Int = 23;
	public static var REL_IGUAL:Int = 24;
	
	
	public static var EEOF:Int = 666;
	
	//Inicia os estados
	public var q0:Estado = new Estado("q0", false);
	public var q1:Estado = new Estado("q1", false);
	public var q2:Estado = new Estado("q2", true);
	public var q3:Estado = new Estado("q3", true);
	public var q4:Estado = new Estado("q4", true);
	public var q5:Estado = new Estado("q5", false);
	public var q6:Estado = new Estado("q6", true);
	public var q7:Estado = new Estado("q7", true);
	public var q8:Estado = new Estado("q8", true);
	public var q9:Estado = new Estado("q9", true);
	
	public var q10:Estado = new Estado("q10", true);
	public var q11:Estado = new Estado("q11", true);
	public var q12:Estado = new Estado("q12", true);
	public var q13:Estado = new Estado("q13", false);
	public var q14:Estado = new Estado("q14", true);
	public var q15:Estado = new Estado("q15", false);
	public var q16:Estado = new Estado("q16", true);
	public var q17:Estado = new Estado("q17", true);
	public var q18:Estado = new Estado("q18", false);
	public var q19:Estado = new Estado("q19", true);
	
	public var q20:Estado = new Estado("q20", true);
	public var q21:Estado = new Estado("q21", false);
	public var q22:Estado = new Estado("q22", true);
	public var q23:Estado = new Estado("q23", true);
	//public var q24:Estado = new Estado("q24", false);
	//public var q25:Estado = new Estado("q25", true);
	public var q26:Estado = new Estado("q26", true);
	public var q27:Estado = new Estado("q27", true);
	public var q28:Estado = new Estado("q28", true);
	public var q29:Estado = new Estado("q29", false);
	
	public var q30:Estado = new Estado("q30", false);
	public var q31:Estado = new Estado("q31", false);
	public var q32:Estado = new Estado("q32", false);
	public var q33:Estado = new Estado("q33", false);
	public var q34:Estado = new Estado("q34", false);
	public var q35:Estado = new Estado("q35", true);
	public var q36:Estado = new Estado("q36", false);
	public var q37:Estado = new Estado("q37", false);
	public var q38:Estado = new Estado("q38", false);
	public var q39:Estado = new Estado("q39", false);
	public var q39b:Estado = new Estado("q39b", false);
	
	public var q40:Estado = new Estado("q40", true);
	public var q41:Estado = new Estado("q41", true);
	public var q42:Estado = new Estado("q42", true);
	public var q43:Estado = new Estado("q43", false);
	public var q44:Estado = new Estado("q44", true);
	
	public var q45:Estado = new Estado("q45", false);
	public var q46:Estado = new Estado("q46", false);
	public var q47:Estado = new Estado("q47", true);
	
	

	public function new() 
	{
		//Modo de usar
		//Inicia as transições
		//q0.addTransicao(Reg.ALFABETO, q1);
		
		//Inicia os tokens
		//q1.addToken(INDETERMINADO);
		
		
		//Iniciando todas as transições do automato
		
		//Q0 --->
		q0.addTransicao(Reg.LETRAS, q1);
		q0.addTransicao(Reg.UNDERLINE, q1);
		
		q0.addTransicao(Reg.ESPACO, q0);
		q0.addTransicao(Reg.QUEBRALINHA2, q0);
		
		q0.addTransicao(Reg.QUEBRALINHA, q6);
		
		q0.addTransicao("+", q3);
		
		q0.addTransicao("-", q4);
		
		q0.addTransicao("*", q5);
		
		q0.addTransicao("/", q7);
		
		q0.addTransicao("(", q9);
		
		q0.addTransicao(")", q10);
		
		q0.addTransicao("{", q11);
		
		q0.addTransicao("}", q12);
		
		q0.addTransicao("&", q27);
		
		q0.addTransicao("|", q28);
		
		q0.addTransicao(",", q42);
		
		q0.addTransicao("\"", q13);
		
		q0.addTransicao(">", q15);
		
		q0.addTransicao("<", q18);
		
		q0.addTransicao("=", q21);
		
		q0.addTransicao("!", q26);

		q0.addTransicao(Reg.NUMEROS, q43);
		
		
		//Q1 --->
		q1.addTransicao(Reg.LETRAS, q1);
		q1.addTransicao(Reg.NUMEROS, q1);
		q1.addTransicao(Reg.UNDERLINE, q1);
		
		//Quando ler qlqr outra coisa
		q1.addTransicao(Reg.OPERADORES_ARITMETICOS, q2);
		q1.addTransicao(Reg.OPERADORES_LOGICOS, q2);
		q1.addTransicao(Reg.OPERADORES_RELACIONAIS, q2);
		q1.addTransicao(Reg.ESPECIAIS, q2);
		q1.addTransicao(Reg.ESPACO, q2); 
		q1.addTransicao(Reg.QUEBRALINHA, q2);
		q1.addTransicao("{", q2);
		q1.addTransicao("=", q2);
		q1.addTransicao(",", q2);
		q1.addTransicao(".", q29);
		
		
		//Q5 --->
		q5.addTransicao("*", q8);
		
		q5.addTransicao(Reg.LETRAS, q41);
		q5.addTransicao(Reg.NUMEROS, q41);
		q5.addTransicao(Reg.ESPECIAIS, q41);
		q5.addTransicao(Reg.ESPACO, q41);
		q5.addTransicao("-", q41);
		
		
		//Q13 --->
		var maiusculas:Array<String> = [for (i in 0...Reg.LETRAS.length) Reg.LETRAS[i].toUpperCase() ];
		q13.addTransicao("\"", q14);
		
		q13.addTransicao(maiusculas, q13);
		q13.addTransicao(Reg.LETRAS, q13);
		q13.addTransicao(Reg.NUMEROS, q13);
		q13.addTransicao(Reg.OPERADORES_ARITMETICOS, q13);
		q13.addTransicao(Reg.OPERADORES_LOGICOS, q13);
		q13.addTransicao(Reg.OPERADORES_RELACIONAIS, q13);
		q13.addTransicao(Reg.ESPECIAIS, q13);
		q13.addTransicao(Reg.ESPACO, q13);
		q13.addTransicao(["_", "!", "@", "#", "$", "%", "~", ";", ":", "[", "]",",", "="], q13);
		
		
		//Q15 --->
		q15.addTransicao("=", q17);
		
		q15.addTransicao(Reg.LETRAS, q16);
		q15.addTransicao(Reg.NUMEROS, q16);
		q15.addTransicao(Reg.ESPECIAIS, q16);
		q15.addTransicao(Reg.ESPACO, q16);
		q15.addTransicao("-", q16);
		
		//Q18 --->
		q18.addTransicao("=", q19);
		
		q18.addTransicao(Reg.LETRAS, q20);
		q18.addTransicao(Reg.NUMEROS, q20);
		q18.addTransicao(Reg.ESPECIAIS, q20);
		q18.addTransicao(Reg.ESPACO, q20);
		q18.addTransicao("-", q20);
		
		//Q21 --->
		q21.addTransicao("=", q22);
		q21.addTransicao(Reg.QUEBRALINHA, q23);
		q21.addTransicao(Reg.LETRAS, q23);
		q21.addTransicao(Reg.NUMEROS, q23);
		q21.addTransicao(Reg.ESPECIAIS, q23);
		q21.addTransicao(Reg.ESPACO, q23);
		q21.addTransicao(Reg.OPERADORES_ARITMETICOS, q23);
		q21.addTransicao(Reg.OPERADORES_LOGICOS, q23);
		q21.addTransicao(Reg.OPERADORES_RELACIONAIS, q23);
		q21.addTransicao(",", q23);
		q21.addTransicao("-", q23);
		
		//Q29 ---> IO.WRITE
		q29.addTransicao("w", q30);
		q30.addTransicao("r", q31);
		q31.addTransicao("i", q32);
		q32.addTransicao("t", q33);
		q33.addTransicao("e", q34);
		q34.addTransicao("(", q35);
		
		//Q29 ---> IO.READ
		q29.addTransicao("r", q36);
		q36.addTransicao("e", q37);
		q37.addTransicao("a", q38);
		q38.addTransicao("d", q39);
		q39.addTransicao("(", q39b);
		
		q39b.addTransicao(")", q40);
		
		
		//Q43 --->
		q43.addTransicao(Reg.NUMEROS, q43);
		q43.addTransicao(".", q45);
		
		q43.addTransicao(Reg.ESPACO, q44);
		q43.addTransicao(Reg.OPERADORES_ARITMETICOS, q44);
		q43.addTransicao(Reg.OPERADORES_LOGICOS, q44);
		q43.addTransicao(Reg.OPERADORES_RELACIONAIS, q44);
		q43.addTransicao(Reg.QUEBRALINHA, q44);
		q43.addTransicao(Reg.ESPECIAIS, q44);
		q43.addTransicao(",", q44);
		q43.addTransicao("=", q44);
		
		//Q45 --->
		q45.addTransicao(Reg.NUMEROS, q46);
		
		//Q46 --->
		q46.addTransicao(Reg.NUMEROS, q46);
		
		q46.addTransicao(Reg.ESPACO, q44);
		q46.addTransicao(Reg.OPERADORES_ARITMETICOS, q44);
		q46.addTransicao(Reg.OPERADORES_LOGICOS, q44);
		q46.addTransicao(Reg.OPERADORES_RELACIONAIS, q44);
		q46.addTransicao(Reg.QUEBRALINHA, q44);
		q46.addTransicao(Reg.ESPECIAIS, q44);
		q46.addTransicao(",", q44);
		
		
		
		
		
		
		//Adicionando os TOKENS dos estados
		q2.addToken(INDETERMINADO);
		q6.addToken(QUEBRA_LINHA);
		q3.addToken(SOMA);
		q4.addToken(SUBT);
		q7.addToken(DIVI);
		q9.addToken(ABRE_PAREN);
		q10.addToken(FECHA_PAREN);
		q11.addToken(ABRE_CHAVE);
		q12.addToken(FECHA_CHAVE);
		q27.addToken(LOG_AND);
		q28.addToken(LOG_OR);
		q14.addToken(SSTRING);
		q16.addToken(REL_MAIOR);
		q17.addToken(REL_MAIOR_IGUAL);
		q19.addToken(REL_MENOR_IGUAL);
		q20.addToken(REL_MENOR);
		q23.addToken(ATT);
		q22.addToken(REL_IGUAL);
		q26.addToken(LOG_NOT);
		q8.addToken(POT);
		q41.addToken(MULT);
		q35.addToken(IO_WRITE);
		q40.addToken(IO_READ);
		q42.addToken(VIRGULA);
		q44.addToken(NUM);
		q47.addToken(EEOF);
		
		
		
		//Se o estado "devolve" (não mexe a fita) o simbolo depois de consumir
		q2.devolve = true;
		q16.devolve = true;
		q20.devolve = true;
		q23.devolve = true;
		q35.devolve = true;
		q41.devolve = true;
		q44.devolve = true;
		
		
	}
	
}