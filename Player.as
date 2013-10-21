// Stellarnaut Player

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;
	import net.flashpunk.masks.*

	public class Player extends Entity {
		[Embed(source="assets/Player.png")]
		private var playerM:Class;
		[Embed(source="assets/PlayerLeft.png")]
		private var playerL:Class;
		[Embed(source="assets/PlayerRight.png")]
		private var playerR:Class;
		public static var playerSpeed:Number = 500;
		public static var shotfired:Boolean = false;
		private var reloadTime:int = 10;
		private var lastShot:Number = reloadTime;
		public static var tempShield:Boolean = false;
		public static var oldY:int;
		public static var oldX:int;

		public var imgM:Image = new Image(playerM);
		public var maskM:Pixelmask = new Pixelmask(playerM);
		public var imgL:Image = new Image(playerL);
		public var maskL:Pixelmask = new Pixelmask(playerL);
		public var imgR:Image = new Image(playerR);
		public var maskR:Pixelmask = new Pixelmask(playerR);
		public var counter:int = 0;
		public static var hp:int = 5;
		public static var hpIncrease:Boolean = false;
		public static var hpDecrease:Boolean = false;
		public var shieldcount:int = 0;
		public static var shield:Boolean = false;

		public static var killed:Boolean = false;
		private var myspeed:Number = playerSpeed;
		private var killedcounter:Number = 0;
		public static var showFlames:Boolean = false;

		public static var width:int;
		public static var height:int;
		public var playerDeathCount:int = 0;

		public function Player():void {
			width = imgM.width;
			height = imgM.height;
			graphic = imgM;
			x = (FP.screen.width / 2) - (width / 2);
			oldX = x;
			if (!oldY) {
				y = (FP.screen.height / 2) - (height /2) + 160;
			}
			else {
				y = oldY;
			}
			type = "player"
		}

		override public function update():void {
			move();
			shoot();
			collision();
			timeToFire();
			shield();
		}

		public function move():void {
			if (!killed) {
				if (Input.check(Key.DOWN) ) {
					y += playerSpeed * FP.elapsed;
					if (y > FP.screen.height - imgM.height -15) {
						y -= playerSpeed * FP.elapsed;
					}
				}
				if (Input.check(Key.UP) ) {
					y -= playerSpeed * FP.elapsed;
					SWorld.prop1.explode(x+width/2, y+height);
					if (y < 20) {
						y += playerSpeed * FP.elapsed;
					}
				}
				if (Input.check(Key.LEFT) ) {
					x -= playerSpeed * FP.elapsed;
					SWorld.prop1.explode(x+width/2, y+height);
					if (x <= 0) {
						x += playerSpeed * FP.elapsed;
					}
					width = imgL.width;
					height = imgL.height;
					mask = maskL;
					graphic = imgL;
				}
				if (Input.check(Key.RIGHT) ) {
					x += playerSpeed * FP.elapsed;
					SWorld.prop1.explode(x+width/2, y+height);
					if (x > FP.screen.width - imgM.width) {
						x -= playerSpeed * FP.elapsed;
					}
					width = imgR.width;
					height = imgR.height;
					mask = maskR;
					graphic = imgR;
				}
				if ( (!Input.check(Key.RIGHT)) && (!Input.check(Key.LEFT)) ) {
					width = imgM.width;
					height = imgM.height;
					mask = maskM;
					graphic = imgM;
				}
				oldY = y;
				oldX = x;
			}
		}

		private function shoot():void {
			if (Input.check(Key.SPACE) ) {
				if (lastShot >= reloadTime) {
					cameraShake.activateCameraJitter(5);
					world.add(new Bullet(x + width / 2-Bullet.bw/2, y - Bullet.bh-4));
					lastShot = 0;
					shotfired = true;
				}
			}
		}

		private function collision():void {
			var power1:powerUp1 = collide("powerUp1", x, y) as powerUp1;
			if (power1) {power1.destroy(); Bullet.bw += 10;}
			var power2:powerUp2 = collide("powerUp2", x, y) as powerUp2;
			if (power2) {power2.destroy(); hp++; hpIncrease = true;}

			if (tempShield) {
				counter++; if (counter > 72) {tempShield = false;}
			}
			else {
			var enemy:Enemy1 = collide("enemy", x, y) as Enemy1;
			var enemy2:Enemy2 = collide("enemy", x, y) as Enemy2;
			var enemy3:Enemy3 = collide("enemy", x, y) as Enemy3;
			var enemy4:Enemy4 = collide("enemy4", x, y) as Enemy4;
			var enemy5:Enemy5 = collide("enemy", x, y) as Enemy5;
			var enemy42:Enemy42 = collide("enemy42", x, y) as Enemy42;
			var boss:Boss = collide("boss", x, y) as Boss;
			var shot:enemyShot = collide("enemyShot", x, y) as enemyShot;
			var bBullet:bossBullet = collide("bossBullet", x, y) as bossBullet;
			if (enemy || enemy2 || enemy3 || enemy4 || enemy42 || enemy5 || shot || boss || bBullet) {
				if (enemy) {SWorld.exp1.explode(enemy.x+enemy.width/2,enemy.y+enemy.height/2);enemy.destroy();}
				if (enemy2) {SWorld.exp1.explode(enemy2.x+enemy2.width/2,enemy2.y+enemy2.height/2);enemy2.destroy();}
				if (enemy3) {SWorld.exp1.explode(enemy3.x+enemy3.width/2,enemy3.y+enemy3.height/2);enemy3.destroy();}
				if (enemy4) {SWorld.exp1.explode(enemy4.x+enemy4.width/2,enemy4.y+enemy4.height/2);enemy4.destroy();}
				if (enemy42) {SWorld.exp1.explode(enemy42.x+enemy42.width/2,enemy42.y+enemy42.height/2);enemy42.destroy();}
				if (enemy5) {SWorld.exp1.explode(enemy5.x+enemy5.width/2,enemy5.y+enemy5.height/2);enemy5.destroy();}
				if (shot) {shot.destroy();}
				hp--;
				hpDecrease = true;
				shield = true;
				if (hp == 0) {
				SWorld.exp3.explode(x+width/2,y+height/2);
				killed = true;
				MochiEvents.trackEvent("killed");
				playerDeathCount++;
				if (HUD.kong) {
					Kongregate.submit("Player Death Count", playerDeathCount);
					Kongregate.submit("Enemies Killed", SWorld.EnemyKillCount)
				}

				SWorld.saveLSO();
				HUD.gameOverText1.text = "You Died - Your Score Was: " + String(SWorld.score);
				HUD.gameOverText2.text = "Your Highest Score Ever: " + String(SWorld.highScore);
				HUD.gameOverText3.text = "Don't Give up! Hit Enter To Respawn!";
				HUD.gameOver = true;

				cameraShake.activateCameraJitter(20);
				destroy();
				}
			}
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

		private function timeToFire():void {
			if (shotfired) {
				lastShot += 1;
			}
			if (lastShot >= reloadTime) {
				shotfired = false;
			}
		}

		private function shield():void {
			shieldcount++
			if (shieldcount >= 120) { // orig 120, take up to 240 if too easy
				if (hp < 5) {hp++; hpIncrease = true;}
				shieldcount = 0
			}
		}

	}
}

