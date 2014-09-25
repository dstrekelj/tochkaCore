package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Obstacle extends Entity
{
	public static var isOnCamera : Bool;
	
	public function new() : Void
	{
		super();
		
		graphic = Image.createCircle(20, 0x44bbff, 100);
		setHitbox(30, 30, -5, -5);
		type = "obstacle";
		
		layer = 1;
	}
	
	public function init() : Void
	{
		x = HXP.width;
		y = (HXP.height - 40) * HXP.random;
		vFactor = HXP.random;
	}
	
	override public function update() : Void
	{
		super.update();
		
		moveBy(-(velocity + (velocity * vFactor)), 0);
		
		if (!onCamera)
		{
			isOnCamera = false;
			scene.recycle(this);
		}
		else
		{
			isOnCamera = true;
		}
	}
	
	private var velocity : Float = 7.0;
	private var vFactor : Float;
}