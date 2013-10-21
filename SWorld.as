// Stellarnaut world file

package {
	import net.flashpunk.*;
	import Math;
	import net.flashpunk.utils.*;
	import flash.net.SharedObject;
	import net.flashpunk.Sfx;
	import flash.geom.Point;
	import net.flashpunk.graphics.*;
	import mochi.as3.*;

	public class SWorld extends World {
		public static var score:Number = 0;
		public static var pause:Boolean = false;
		public static var highScore:int;
		public static var mute:Boolean = false;
		private var spawnTimer:Number = 4.5;
		public var spawnLimit:Number = 0.75;
		public var enemy2timer:Number = 6;
		public var enemy3timer:Number = 8;
		public var enemy5timer:Number = 8;
		private var field:Stars = new Stars();
		public static var exp1:EmitterEntity = new EmitterEntity();
		public static var prop1:Emitter2 = new Emitter2();
		public static var exp3:Emitter3 = new Emitter3();
		public static var nopowerUp:Boolean = true
		public var ConnectKong:Boolean = false;
		public static var EnemyKillCount:Number = 0;
		public static var blur:MotionBlur = new MotionBlur(0.9);
		public static var bloom:BloomLighting = new BloomLighting(10,1);
		public static var time:int = 0;
		public static var Meter:Entity = new LifeBar();

		[Embed(source="assets/sounds.swf#music")]
		public static var musicSound:Class;
		public static var music:Sfx = new Sfx(musicSound);

		public function SWorld() {
			FP.screen.color = 0x000000;

			var lso:SharedObject = SharedObject.getLocal("StellarnautScore");
			if (lso.data.savedData == null) {
				highScore = score;
			}
			else {
				highScore = int(lso.data.savedData);
			}
			lso.flush();

			add(new Player);
			add(new shield);
			add(new HUD);
			add(new cameraShake);
			add(exp1);
			add(prop1);
			add(exp3);
			add(blur);
			add(bloom);
			add(Meter);
			resetSpawnTimer();
		}

		override public function update():void {
			if (HUD.kong && !ConnectKong) {Kongregate.connect(FP.stage); Kongregate.submit("Started Game", 1); ConnectKong = true;}
			if (Input.pressed(Key.P)) {
				pause = !pause;
				if (pause) {music.stop();}
			}

			if (!pause) {
			if (Input.pressed(Key.M)) {
				mute = !mute;
				if (mute) {music.stop(); MochiEvents.trackEvent("Music Stopped");}
			}
				if (!Player.killed) {time++;}
			spawnTimer -= FP.elapsed;
			if (spawnTimer < 0) {
				spawnEnemy();
				resetSpawnTimer();
			}
			if (time/Stellarnaut.fps == 180) {var bossAdd:Boolean = true;}
			if (bossAdd) {add(new Boss(FP.width/2, - (100 + Boss.h))); add(new BossBar); bossAdd = false;}
			if (score >= 1000) {
				if (spawnTimer == 4.5) {spawnTimer = 5.5;}
				enemy2timer -= 0.05;
				if (enemy2timer <= 0) {
					spawnEnemy2();
					enemy2timer = 6;
				}
			}
			if (score >= 2000) {
				if (spawnTimer == 5.5) {spawnTimer = 6.5;}
				enemy3timer -= 0.05;
				if (enemy3timer <= 0) {
					spawnEnemy3();
					enemy3timer = 40;
				}
			}

			if (score >= 2500) {
				if (spawnTimer == 5.5) {spawnTimer = 6.5;}
				enemy5timer -= 0.05;
				if (enemy5timer <= 0) {
					spawnEnemy5();
					enemy5timer = 40;
				}
			}

			if (score == 100 && nopowerUp) {add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 12;}
			if (score == 500 && !nopowerUp) {add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bh = 10;}
			if (score == 1000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}
			if (score == 2000 && !nopowerUp) { add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 12;}
			if (score == 4000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bh = 10;}
			if (score == 6000 && !nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}
			if (score == 8000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 12;}
			if (score == 10000 && !nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bh = 10;}
			if (score == 12000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}
			if (score == 14000 && !nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 12;}
			if (score == 16000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bh = 10;}
			if (score == 18000 && !nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}
			if (score == 20000 && nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp2((Math.random() * ((FP.screen.width-(powerUp2.w *2)) + powerUp2.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}
			if (score == 25000 && !nopowerUp) {add(new Enemy4(-100,0)); add(new Enemy42()); add(new powerUp1((Math.random() * ((FP.screen.width-(powerUp1.w *2)) + powerUp1.w)), 0)); nopowerUp = !nopowerUp;}//Bullet.bw = 20;}

			if (!mute && !pause) {
				if (Intro.musicStarted && !music.playing) {music.resume();}
			}

			field.update();
			super.update();
		}
	}

		override public function render():void {
			field.render(FP.buffer, new Point, FP.camera);
			super.render();
		}

		public static function saveLSO():void {
			var lso:SharedObject = SharedObject.getLocal("StellarnautScore");
			if (lso.data.savedData == null) {
				highScore = score;
			}
			else {
				highScore = int(lso.data.savedData);
				if (score > highScore) {
					highScore = score;
				}
			}
			lso.data.savedData = highScore;
			lso.flush();
		}

		private function spawnEnemy():void {
			var _x:Number = Math.random() * ((FP.screen.width-(Enemy1.w *2)) + Enemy1.w);
			var _y:Number =  -50;
			add(new Enemy1(_x, _y));
		}

		private function spawnEnemy2():void {
			var _x:Number = Math.random() * ((FP.screen.width-(Enemy2.w *2)) + Enemy2.w);
			var _y:Number =  -100;
			add(new Enemy2(_x, _y));
		}

		private function spawnEnemy3():void {
			var _x:Number = Math.random() * ((FP.screen.width-(Enemy3.w *2)) + Enemy3.w);
			var _y:Number =  -180;
			add(new Enemy3(_x, _y));
		}

		private function spawnEnemy5():void {
			var _x:Number = Math.random() * ((FP.screen.width-(Enemy5.w *2)) + Enemy5.w);
			var _y:Number =  -130;
			add(new Enemy5(_x, _y));
		}


		private function resetSpawnTimer():void {
			spawnTimer *= 0.5
			if (spawnTimer < spawnLimit) {
				spawnTimer = spawnLimit;
			}
		}


	}
}
