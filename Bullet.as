// Stellarnaut bullet

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class Bullet extends Entity {
		private var speed:int = 1000;//2000;
		public static var initBW:int = 8;
		public static var initBH:int = 1;
		public static var bw:int = initBW;
		public static var bh:int = initBH;

		public function Bullet(_x:int, _y:int) {
			x = _x;
			y = _y;
			width = bw;
			height = bh;
			var sprite:BlurWrapper = new BlurWrapper(Image.createRect(width,height,0xFF0000), SWorld.blur);
			graphic = sprite;
			type = "bullet";
		}

		override public function update():void {
			y -= speed * FP.elapsed;
			width = bw;
			height = bh;
			if (y < -10) {
				destroy();
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}
}
