// Stellarnaut Enemy weapon

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class enemyShot extends Entity {
		private var speed:int = 500;
		public static var remove:Boolean = false;

		public function enemyShot(_x:int, _y:int) {
			x = _x;
			y = _y;
			width = 4
			height = 4
			var sprite:BloomWrapper = new BloomWrapper(Image.createRect(width,height,0xFFFFFF));
			SWorld.bloom.register(sprite);
			graphic = sprite;
			type = "enemyShot";
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
