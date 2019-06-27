package modules;

import defold.types.Message;
import defold.Msg;
import lua.Table;
import defold.Physics;
import defold.Go;
import defold.Vmath;
import defold.types.Vector3;

class Interact extends TimedAction {
    public static var INTERACT(default, never) = new Message<Void>("interact");

    public function interact(dir:Vector3): Bool {
        if (canAct && Vmath.length_sqr(dir) == 1) {
            var pos = Go.get_position();
            var to = pos + dir * 16;
            var ray = Physics.raycast(pos, to, Table.fromArray([Defold.hash("objects")]));

            if (ray == null) {
                resetTimer();
                Msg.post(ray.id, INTERACT);
                return true;
            }
        }
        return false;
    }
}