package;
import flixel.effects.FlxSpriteFilter;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

/**
 * ...
 * @author lagemanngui
 */
class IniProgramState extends FlxState
{

	override public function create():Void
	{
		super.create();
		
		
		
		FlxG.mouse.useSystemCursor = true;
		
		add(new FlxSprite(0, 0, "assets/hud/title.png"));
		
		
		var button = new FlxButton(369, 213, "", flashThis);
		button.makeGraphic(242, 73, 0x00000000);
		
		
		add(button);
		
	}
	public function flashThis():Void
	{
		FlxG.camera.flash(0xffffffff, 0.8,  inicar);
	}
	public function inicar():Void
	{
		var p:ProgramState = new ProgramState();
		FlxG.switchState(p);
		
		return null;
	}
	
}