package modules;

class TimedAction {
    private final cooldown:Float;
    private var timer:Float;
    private var canAct:Bool = true;

    public function new(cooldown:Float) {
        this.cooldown = cooldown;
        this.timer = cooldown;
    }

    public function update(dt:Float) {
        if (!canAct) {
            timer -= dt;
        }
        if (timer <= 0) {
            canAct = true;
        }
    }

    private function resetTimer() {
        timer = cooldown;
        canAct = false;
    }
}