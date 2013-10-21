package {

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;

	public class EmitterEntity extends Entity {
		private var emitter:Emitter;
		private var partical_count:int = 500;

		public function EmitterEntity() {
			emitter = new Emitter(Assets.expParticle);
			emitter.newType('explode', [0]);
			emitter.setMotion('explode', 0, 100, 0.3, 360, 20, 1);
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
