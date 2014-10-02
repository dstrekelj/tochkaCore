import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.Scene;

import scenes.Game;

class Main extends Engine
{
	public static var sceneGame : Scene;
	
	override public function new(width : Int = 0, height : Int = 0, frameRate : Float = 60, fixed : Bool = false) : Void
	{
		super(640, 480, 60, true);
	}
	
	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		sceneGame = new Game();
		
		HXP.scene = sceneGame;
	}

	public static function main()
	{
		new Main();
	}
}