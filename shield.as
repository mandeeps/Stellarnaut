// shield

// Supernaut Player

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	public class shield extends Entity {
		[Embed(source = 'assets/shield.png')]
		private const shieldimg:Class;
		public var sprShield:Spritemap = new Spritemap(shieldimg, 128,100);
		public var count:int = 0;

		public function shield():void {
			sprShield.add("play", [0,1,2,3],30,true);
			graphic = sprShield;
			x = 0;
			y = 0;
			width = 128;
			height = 100;
			visible = false;
		}

		override public function update():void {
			if (Player.shield) {
				sprShield.play("play");
				x = (Player.oldX+Player.width/2-10); //(Player.oldX-10);
				y = (Player.oldY+Player.height/2-20); //(Player.oldY-20);
				visible = true;
				if (count < 5) {
					count++
				}
				if (count >=5) {
					Player.shield = false;
					count = 0
					visible = false;
				}

			}
		}

	}
}
