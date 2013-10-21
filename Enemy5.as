// Stellarnaut Enemy5

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*

	public class Enemy5 extends Entity {

		[Embed(source="assets/Enemy5.png")]
		public var Enemy5class:Class;
		public static var speed:Number = 20;
		public var health:int = 7;
		public var curHealth:int = health;
		private var myspeed:Number = speed;
		private var killedcounter:Number = 0;
		private var killed:Boolean = false;
		public static var w:Number;
		public var shotfired:Boolean = false;
		private var reloadTime:int = 30;
		private var lastShot:Number = reloadTime;

		public function Enemy5(_x:int, _y:int):void {
			var img:Image = new Image(Enemy5class);
			mask = new Pixelmask(Enemy5class);
			width = img.width;
			w = width;
			height = img.height;
			var sprite:BloomWrapper = new BloomWrapper(new BlurWrapper(img, SWorld.blur));
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
				SWorld.score += 1000;
				myspeed = 0;
				killed = true;
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
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
			if (y >= FP.screen.height) {destroy();}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

		public function fire(x:int,y:int):void {
			lastShot++
			if (lastShot >= reloadTime) {
				world.add(new enemyShot((x+width/2),y+height));
				world.add(new enemyShot((x+width/2),y+height+10));
				world.add(new enemyShot((x+width/2),y+height+20));
				lastShot = 0;
				shotfired = true;
			}
		}

	}
}
