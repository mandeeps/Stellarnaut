package {

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;

	public class Emitter3 extends Entity {
		private var emitter:Emitter;
		private var partical_count:int = 100;

		public function Emitter3() {
			emitter = new Emitter(Assets.playerParticle);
			emitter.newType('explode', [0]);
			emitter.setMotion('explode', 0, 50, 0.2, 360, 20, 1);
			this.graphic = emitter;
		}

		override public function update():void {
		}

		public function explode(x:Number, y:Number):void {
			for (var i:int = 0; i < this.partical_count; i++) {
				emitter.emit('explode', x, y);
			}
		}

	}
}
