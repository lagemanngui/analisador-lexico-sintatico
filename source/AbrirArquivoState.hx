package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;

/**
 * ...
 * @author lagemanngui
 */
class AbrirArquivoState extends FlxSubState
{
	private var programParent:ProgramState;

	override public function create():Void
	{
		var fundo = new FlxSprite(0, 0);
		fundo.makeGraphic(640, 480, 0xff111111);
		fundo.alpha = 0.6;
		add(fundo);
		
		var prog1:FlxButton = new FlxButton(0, 200, "prog_1.txt", open_1);
		prog1.label.color = 0xffffffff;
		prog1.loadGraphic("assets/hud/botao prog.png");
		
		var prog2:FlxButton = new FlxButton(90, 200, "prog_2.txt", open_2);
		prog2.label.color = 0xffffffff;
		prog2.loadGraphic("assets/hud/botao prog.png");
		
		var prog3:FlxButton = new FlxButton(180, 200, "prog_3.txt", open_3);
		prog3.label.color = 0xffffffff;
		prog3.loadGraphic("assets/hud/botao prog.png");
		
		var prog4:FlxButton = new FlxButton(270, 200, "prog_4.txt", open_4);
		prog4.label.color = 0xffffffff;
		prog4.loadGraphic("assets/hud/botao prog.png");
		
		
		var custom:FlxButton = new FlxButton(360, 200, "CUSTOM", open_custom);
		custom.label.color = 0xffffffff;
		custom.loadGraphic("assets/hud/botao prog.png");
		
		var fechar:FlxButton = new FlxButton(450, 200, "FECHAR", closeThis);
		fechar.label.color = 0xffffffff;
		fechar.loadGraphic("assets/hud/botao prog.png");
		
		
		
		add(prog1);
		add(prog2);
		add(prog3);
		add(prog4);
		add(custom);
		add(fechar);
		
		forEachOfType(FlxButton, moverDireita);
		
	}
	public function moverDireita(a:FlxButton):Void
	{
		a.x += 40;
		a.label.offset.y = -20;
		
		var destX = a.x;
		
		FlxTween.linearMotion(a, -100, a.y, destX, a.y, 0.3);
	}
	public function setParentProgram(a:ProgramState):Void
	{
		programParent = a;
	}
	public function open_1():Void
	{
		Reg.CURRENT_FILE = "prog_1.txt";
		closeThis();
	}
	public function open_2():Void
	{
		Reg.CURRENT_FILE = "prog_2.txt";
		closeThis();
	}
	public function open_3():Void
	{
		Reg.CURRENT_FILE = "prog_3.txt";
		closeThis();
	}
	public function open_4():Void
	{
		Reg.CURRENT_FILE = "prog_4.txt";
		closeThis();
	}
	public function open_custom():Void
	{
		Reg.CURRENT_FILE = "prog_custom.txt";
		closeThis();
	}
	public function closeThis():Void
	{
		programParent.reload();
		close();
	}
	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.justPressed.A)
		{
			close();
		}
	}
	
}