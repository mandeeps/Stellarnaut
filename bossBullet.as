// boss bullet
package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class bossBullet extends Entity {
		private var speed:int = 500;
		public static var remove:Boolean = false;

		public function bossBullet(_x:int, _y:int) {
			x = _x;
			y = _y;
			width = 4
			height = 4
			graphic = Image.createRect(width,height,0xFFFF00);
			type = "bossBullet";
		}

		override public function update():void {
			y += speed * FP.elapsed;
			if (y > FP.screen.height || remove) {
				destroy();
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}

}
