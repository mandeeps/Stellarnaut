// Stellarnaut Enemy4

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*

	public class Enemy4 extends Entity {

		[Embed(source="assets/Enemy4Small.png")]
		public var Enemy4class:Class;
		public static var speed:Number = 150;
		private var myspeed:Number = speed;
		private var killedcounter:Number = 0;
		private var killed:Boolean = false;
		public static var w:Number;
		public var shotfired:Boolean = false;
		private var reloadTime:int = 5;
		private var lastShot:Number = reloadTime;

		public function Enemy4(_x:int, _y:int):void {
			var img:Image = new Image(Enemy4class);
			mask = new Pixelmask(Enemy4class);
			width = img.width;
			w = width;
			height = img.height;
			var sprite:BloomWrapper = new BloomWrapper(new BlurWrapper(img, SWorld.blur)); //img;
			SWorld.bloom.register(sprite);
			graphic = sprite;
			x = _x;
			y = _y;
			type = "enemy4"
		}

		override public function update():void {
			if (!killed) {move(); if (y < FP.screen.height-height) {fire(x,y);}}
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
				SWorld.score += 500;
				bullet.destroy();
				killed = true;
			}
			if (killed) {
				killedcounter++;
			}
			if (killedcounter >= 2) {
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.EnemyKillCount++;
				destroy();
				}
		}
		private function move():void {
			x += myspeed * FP.elapsed;
			if (x > FP.screen.width) {destroy();}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

		public function fire(x:int,y:int):void {
			lastShot++
			if (lastShot >= reloadTime) {
				world.add(new enemyShot((x+width/2),y+height-5));
				lastShot = 0;
				shotfired = true;
			}
		}

	}
}
