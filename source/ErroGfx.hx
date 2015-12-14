package;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author lagemanngui
 */
class ErroGfx extends FlxSprite
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		makeGraphic(8, 16, FlxColor.RED);
		alpha = 0.5;
	}
	
}