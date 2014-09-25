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
		_lScore = new Text("SCORE: 0", 16, 16);
		_lRestart = new Text("ENTER TO RESTART", 16, 48);
	}
	
	override public function begin() : Void
	{
		super.begin();
		
		add(_player);
		addGraphic(_lScore);
		addGraphic(_lRestart);
		
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
			var fps : Float = HXP.round(HXP.frameRate, 2);
			var mem : Float = HXP.round(System.totalMemory / 1024 / 1024, 2);
			trace("<sample>\n\t<fps>" + fps + "</fps>\n\t<memory>" + mem + "</memory>\n</sample>");
			_logTimer = 0;
		}
	}
	
	private var _player : Player;
	
	private var _score : Float;
	private var _spawnTimer : Float;
	private var _SPAWN_RATE : Float = 0.3;
	
	private var _lScore : Text;
	private var _lRestart : Text;
}