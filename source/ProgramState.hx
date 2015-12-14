package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import haxe.Resource;
import sys.io.File;
import openfl.Assets;
import haxe.io.Eof;

/**
 * ...
 * @author lagemanngui
 */
class ProgramState extends FlxState
{
	
	public var automato:Automato;
	public var sintatico:Sintatico;
	public var lexico:Lexico;
	
	public var textTokensLidos:FlxText;
	public var programText:FlxText;
	public var erroText:FlxText;
	
	public var abrirArquivo:FlxButton;
	

	override public function create():Void
	{
		super.create();
		
		TokenMap.init();
		
		bgColor = 0xff191919;
		FlxG.mouse.useSystemCursor = true;
		
		var lerArquivo:String = "";
		lerArquivo = File.getContent("assets/progs/" + Reg.CURRENT_FILE);
		
		lerArquivo = StringTools.replace(lerArquivo, "\n", "");
		
		programText = new FlxText(15, 60, 640, "", 12);
		programText.font = "assets/font/SEGOEUI.TTF";
		programText.color = 0xffbdbdbd;
		programText.text = lerArquivo;
		
		textTokensLidos = new FlxText(340, 240, 290, "", 12);
		textTokensLidos.font = "assets/font/SEGOEUI.TTF";
		textTokensLidos.color = 0xff94cc4e;
		textTokensLidos.text = "Pronto.";
		
		
		erroText = new FlxText(340, 55, 640, "Nenhum erro encontrado", 12);
		erroText.font = "assets/font/SEGOEUI.TTF";
		
		
		
		//Interface grafica
		add(new FlxSprite(0, 0, "assets/hud/moldura_frente.png"));
		//add(new FlxSprite(335, 321, "assets/hud/log_box.png"));
		//add(new FlxSprite(335, 25, "assets/hud/moldura_erros.png"));
		
		//Adiciona textos
		add(textTokensLidos);
		add(programText);
		add(erroText);
		
		abrirArquivo = new FlxButton(0, 0, "", abreArquivo);
		abrirArquivo.loadGraphic("assets/hud/abrir.png");
		
		add(abrirArquivo);
		
		var executar = new FlxButton(97,0, "", executarAutomatron);
		executar.loadGraphic("assets/hud/executar.png");
		add(executar);
		
		
		
		
		
		//StringTools.replace(lerArquivo, "\n", "\b");
		
		
		/**
		 * Inicia o automato do analisador lexico
		 */
		automato = new Automato();
		
		
		
		
		/**
		 * Inicia o analisador lexico no estado
		 * inicial do automato, e.g "q0"
		 */
		lexico = new Lexico(automato, lerArquivo, this);
		//lexico.le_token();
		
		
		/**
		 * Inicia o analisador sintatico
		 */
		sintatico = new Sintatico(lexico, this);
		
		
		
		//textTokensLidos.text = "Tokens lidos: " + Std.string(Reg.TOKENS_LIDOS) +
		//"\nEstado Final: " + lexico.getUltimoFinal().getNome();
		
	}
	
	public function executarAutomatron():Void
	{
		sintatico.start();
		updateLogText();
		
	}
	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.justPressed.SPACE)
		{
			sintatico.start();
			updateLogText();
			//textTokensLidos.text = "Tokens lidos: " + Std.string(Reg.TOKENS_LIDOS) +
			//"\nEstado Final: " + lexico.getUltimoFinal().getNome();
		}
	}
	public function updateLogText():Void
	{
		if (lexico.getUltimoFinal() != null)
		{
			var tokenLido = StringTools.replace(Std.string(Reg.TOKENS_LIDOS), "[", "");
			tokenLido = StringTools.replace(tokenLido, "]", "");
			tokenLido = StringTools.replace(tokenLido, ",", " - ");
			
			textTokensLidos.text = "[Tokens lidos]";
			
			for (i in 0...Reg.TOKENS_LIDOS.length)
			{
				textTokensLidos.text += " - " + TokenMap.tokenMap.get(Reg.TOKENS_LIDOS[i]);
			}
			
			textTokensLidos.text += "\n\n[Ultimo Estado] " + lexico.getUltimoFinal().getNome();
		}
	}
	public function reload():Void
	{
		Reg.TOKENS_LIDOS.splice(0, Reg.TOKENS_LIDOS.length);
		FlxG.resetState();
	}
	public function abreArquivo():Void
	{
		var s:AbrirArquivoState = new AbrirArquivoState();
		s.setParentProgram(this);
		openSubState(s);
	}
	public function mostraErro(s:String):Void
	{
		erroText.text = s;
	}
	
}