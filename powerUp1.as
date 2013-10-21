// Stellarnaut powerup 1

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class powerUp1 extends Entity {
		private var speed:int = 500;
		public static var w:int = 20;
		public static var h:int = 20;
		[Embed("assets/powerUp.png")]
		private var powerUp1Image:Class;

		public function powerUp1(_x:int, _y:int) {
			x = _x;
			y = _y;
			var img:Image = new Image(powerUp1Image);
			mask = new Pixelmask(powerUp1Image);
			width = w;
			height = h;
			graphic = img;
			type = "powerUp1";
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
