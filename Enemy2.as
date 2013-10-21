// Stellarnaut Tougher Enemy, requires more hits to kill

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import mochi.as3.*
	import net.flashpunk.masks.*

	public class Enemy2 extends Entity {
		[Embed(source="assets/Enemy2Small.png")]
		public var enem2class:Class;
		private var speed:Number = 60;
		public var health:int = 2;
		public var curHealth:int = health;
		private var killed:Boolean = false;
		private var myspeed:Number = speed;
		private var killedcounter:Number = 0;
		public var shotfired:Boolean = false;
		private var reloadTime:int = 60;
		private var lastShot:Number = reloadTime;
		public static var w:int;

		public function Enemy2(_x:int, _y:int):void {
			var img:Image = new Image(enem2class);
			mask = new Pixelmask(enem2class);
			w = img.width;
			width = img.width;
			height = img.height;
			var sprite:BloomWrapper = new BloomWrapper(new BlurWrapper(img, SWorld.blur)); //img;
			SWorld.bloom.register(sprite);
			graphic = sprite;
			x = _x;
			y = _y;
			type = "enemy"
		}

		override public function update():void {
			if (!killed) {move(); if (y < FP.screen.height-height) {fire(x,y);}}
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
				curHealth -= 1;
				bullet.destroy();
			}
			if (curHealth == 0) {
				SWorld.score += 100;
				myspeed = 0;
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				killed = true;
			}
			if (killed) {
				killedcounter++;
			}
			if (killedcounter >= 2) {
				SWorld.EnemyKillCount++;
				destroy();
				}
		}

		private function move():void {
			y += myspeed * FP.elapsed;
			if (y > FP.screen.height) {destroy();}
		}

		public function fire(x:int,y:int):void {
			lastShot++
			if (lastShot >= reloadTime) {
				world.add(new enemyShot((x+width/2),y+height-13));
				world.add(new enemyShot((x+width/2),y+height-7));
				world.add(new enemyShot((x+width/2),y+height-1));
				lastShot = 0;
				shotfired = true;
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}
}
