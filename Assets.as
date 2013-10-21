package {
	import flash.display.BitmapData;

	public class Assets {

		static public function get expParticle():BitmapData {
			var data:BitmapData = new BitmapData(1, 1, false, 0xFF0000);
			return data;
		}

		static public function get propParticle():BitmapData {
			var data:BitmapData = new BitmapData(1, 1, false, 0x00CDCD);
			return data;
		}

		static public function get playerParticle():BitmapData {
			var data:BitmapData = new BitmapData(1, 1, false, 0xEE4000);
			return data;
		}


	}

}
