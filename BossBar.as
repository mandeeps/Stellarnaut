package
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class BossBar extends Entity
    {
        public var bar:Image = Image.createRect(((Boss.bosshealth)*5),10, 0xFF0000);

        public function BossBar()
        {
			layer = -1;
            super(0, 10, bar);
        }

        override public function update():void
        {
            if (Boss.hpDecrease)
            {
                bar.clipRect.width = FP.approach(bar.clipRect.width, 0, 5);
                bar.clear();
                bar.updateBuffer();
                Boss.hpDecrease = false;
            }
        }
    }
}
