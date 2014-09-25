package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Player extends Entity
{
	public var isReady : Bool;
	public var isAlive : Bool;
	
	public function new() : Void
	{
		super();
		
		graphic = Image.createCircle(20, 0xe0e0d0, 100);
		graphic.x = -20;
		graphic.y = -20;
		setHitbox(30, 30, 15, 15);
		type = "player";
		
		layer = 1;
	}
	
	public function init() : Void
	{
		x = _setX;
		y = _setY;
		
		isReady = false;
		isAlive = true;
		
		visible = true;
	}
	
	override public function added() : Void
	{
		super.added();
		
		Input.define("player_jump", [Key.UP, Key.W, Key.SPACE]);
	}
	
	override public function update() : Void
	{
		super.update();
		
		if (isReady && isAlive)
		{
			collidable = true;
			(_velocity < _gravity) ? _velocity += 0.5 : _velocity = _gravity;
			moveBy(0, _velocity);
			
			if (!onCamera)
			{
				destroy();
			}
				
			if (collide("obstacle", x, y) != null)
			{
				destroy();
			}
		}
		else
		{
			collidable = false;
		}
		
		if (Input.pressed("player_jump") || Input.mousePressed)
		{
			_velocity = -_takeoff;
			if (isAlive)
			{
				// play jump sfx
			}
				
			if (!isReady)
			{
				isReady = true;
			}
		}
	}
	
	public function destroy() : Void
	{
		visible = false;
		isAlive = false;
		isReady = false;
		
		// play death sfx
	}
	
	private var _setX : Float = 100;
	private var _setY : Float = HXP.halfHeight;
	
	private var _gravity : Float = 12;
	private var _takeoff : Float = 8;
	private var _velocity : Float = 0;
}