package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

import entities.Obstacle;
import entities.Player;

import flash.system.System;

class Game extends Scene
{
	public function new() : Void
	{
		super();
		
		_player = new Player();
		_lScore = new Text("SCORE: 0", 20, 20);
		_lRestart = new Text("ENTER TO RESTART", 20, 48);
		_lDebug = new Text("FPS: -- \tMEM: -- ", 4, 2, {color: 0x00ff00});
	}
	
	override public function begin() : Void
	{
		super.begin();
		
		add(_player);
		addGraphic(_lScore);
		addGraphic(_lRestart);
		addGraphic(_lDebug);
		
		init();
	}
	
	private function init() : Void
	{
		_score = 0;
		_spawnTimer = 0;
		
		_player.init();
		
		_lScore.visible = false;
		_lRestart.visible = false;
	}
	
	override public function update() : Void
	{
		super.update();
		
		if (_player.isReady && _player.isAlive)
		{
			play();
		}
		else if (!_player.isAlive)
		{
			showScoreboard();
		}
			
		log(1);
	}
	
	private function play() : Void
	{
		_lScore.visible = true;
		_spawnTimer += HXP.elapsed;
		if (_spawnTimer >= _SPAWN_RATE)
		{
			create(Obstacle, true).init();
			_spawnTimer = 0;
		}
		
		_score += HXP.elapsed;
		_lScore.text = "SCORE: " + Std.int(_score);
	}
	
	private function showScoreboard() : Void
	{
		_lRestart.visible = true;
		
		if (!Obstacle.isOnCamera && Input.pressed(Key.ENTER))
		{
			init();
		}
	}
	
	private var _logTimer : Float = 0;
	private function log(sampleTime : Float) : Void
	{
		_logTimer += HXP.elapsed;
		if (_logTimer >= sampleTime)
		{
			_fps = HXP.round(HXP.frameRate, 2);
			if (_fps > _fpsMax)
			{
				_fpsMax = _fps;
			}
			if (_fps < _fpsMin)
			{
				_fpsMin = _fps;
			}
#if !html5
			var mem : Float = HXP.round(System.totalMemory / 1024 / 1024, 2);
			//trace("<sample>\n\t<fps>" + fps + "</fps>\n\t<memory>" + mem + "</memory>\n</sample>");
			_lDebug.text = 'FPS: $_fps \tMIN: $_fpsMin \tMAX: $_fpsMax \tMEM: $mem';
#else
			_lDebug.text = 'FPS: $_fps \tMIN: $_fpsMin \tMAX: $_fpsMax';
#end
			_logTimer = 0;
		}
	}
	
	private var _player : Player;
	
	private var _score : Float;
	private var _spawnTimer : Float;
	private var _SPAWN_RATE : Float = 0.3;
	
	private var _lScore : Text;
	private var _lRestart : Text;
	private var _lDebug : Text;
	
	private var _fps : Float;
	private var _fpsMin : Float = 60;  
	private var _fpsMax : Float = 0;
}