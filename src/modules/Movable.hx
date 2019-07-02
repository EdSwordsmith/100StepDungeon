package modules;

import defold.types.Hash;
import lua.Table;
import defold.Physics;
import defold.Go;
import defold.Vmath;
import defold.types.Vector3;

class Movable extends TimedAction {
    private var groups:Table<Int, Hash>;

    public function new(cooldown:Float, ?groups:Array<Hash>) {
        super(cooldown);
        this.groups = Table.fromArray([
            Defold.hash("tiles"), 
            Defold.hash("objects"), 
            Defold.hash("enemy")
        ]);
        for (group in groups) {
            Table.insert(this.groups, group);
        }
    }

    public function move(dir:Vector3): Bool {
        if (canAct && Vmath.length_sqr(dir) == 1) {
            var pos = Go.get_position();
            var to = pos + dir * 16;
            var ray = Physics.raycast(pos, to, groups);

            if (ray == null) {
                resetTimer();
                Go.animate(
                    ".", "position", 
                    GoPlayback.PLAYBACK_ONCE_FORWARD, to, 
                    GoEasing.EASING_OUTSINE, cooldown
                );
                return true;
            }
        }
        return false;
    }
}