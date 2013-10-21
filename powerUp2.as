// Stellarnaut powerup 2

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class powerUp2 extends Entity {
		private var speed:int = 500;
		public static var w:int = 20;
		public static var h:int = 20;
		[Embed("assets/powerUp2.png")]
		private var powerUp2Image:Class;

		public function powerUp2(_x:int, _y:int) {
			x = _x;
			y = _y;
			var img:Image = new Image(powerUp2Image);
			mask = new Pixelmask(powerUp2Image);
			width = w;
			height = h;
			graphic = img;
			type = "powerUp2";
		}

		override public function update():void {
			y += speed * FP.elapsed;
			if (y > FP.screen.height) {
				destroy();
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}
}
