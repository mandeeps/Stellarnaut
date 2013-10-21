// Boss

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*

	public class Boss extends Entity {

		[Embed(source="assets/boss.png")]
		public var bossclass:Class;
		[Embed(source="assets/bossL.png")]
		public var bossLclass:Class;
		private var speed:Number = 100;
		public static var bosshealth:int = 30;
		public static var hpDecrease:Boolean = false;
		public static var bosskilled:Boolean = false;
		private var myspeed:Number = speed;
		private var killedcounter:Number = 0;
		public var img:Image = new Image(bossclass);
		public var imgL:Image = new Image(bossLclass);
		public var moveLeft:Boolean = false;
		public var moveRight:Boolean = false;
		public var shotfired:Boolean = false;
		private var reloadTime:int = 20;
		private var lastShot:Number = reloadTime;
		public static var h:int;
		public var spriteR:BloomWrapper = new BloomWrapper(new BlurWrapper(img, SWorld.blur));
		public var spriteL:BloomWrapper = new BloomWrapper(new BlurWrapper(imgL, SWorld.blur));

		public function Boss(_x:int, _y:int):void {
			mask = new Pixelmask(bossclass);
			SWorld.bloom.register(spriteR);
			graphic = spriteR;
			width = img.width;
			height = img.height;
			h = height;
			x = _x;
			y = _y;
			type = "boss"
		}

		override public function update():void {
			move();
			lastShot++
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
				bosshealth -= 1;
				hpDecrease = true;
				SWorld.score += 50;
				bullet.destroy();
			}
			if (bosshealth == 0) {
				SWorld.score += 5000;
				speed = 0;
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				SWorld.exp1.explode(x+width/2,y+height/2);
				visible = false;
				bosskilled = true;
				bosshealth = 1000;
			}
			if (bosskilled) {
				killedcounter++;
			}
			if (killedcounter >= 48) {
				bossBullet.remove = true;
				destroy();
				}
		}

		private function move():void {
			if (visible) {fire(x, y);}
			if (y < 10) {
				y += speed * FP.elapsed;
				moveLeft = true;
			}
			else {
				if (moveLeft) {
					mask = new Pixelmask(bossLclass);
					SWorld.bloom.register(spriteL);
					graphic = spriteL;
					x -= speed * FP.elapsed;
					if (x <= 1) {
						moveLeft = false;
						moveRight = true;
					}
				}
				else if (moveRight) {
					mask = new Pixelmask(bossclass);
					SWorld.bloom.register(spriteR);
					graphic = spriteR;
					x += speed * FP.elapsed;
					if (x >= FP.screen.width - width) {
						moveRight = false;
						moveLeft = true;
					}
				}
			}
		}

		public function destroy():void {
			HUD.gameOver = true;
			HUD.gameWon = true;
			FP.world.remove(this);
		}

		public function fire(x:int,y:int):void {
			if (lastShot >= reloadTime) {
				world.add(new bossBullet(x+94,y+height - 5));//y+104));
				lastShot = 0;
				shotfired = true;
			}
		}


	}
}
