package modules;

import Defold.hash;
import lua.Math;
import lua.Table;
import defold.Physics;
import defold.Vmath;
import defold.types.Vector3;

class Follow {
    public static function getDir(pos:Vector3, target:Vector3):Vector3 {
        var dir = Vmath.vector3();
        var delta = target - pos;
        // make sure delta is never (0, 0)
        if (delta.x == 0 && delta.y == 0) {
            delta.x = -1;
        }

        // set dir to normalized delta
        if (Math.abs(delta.x) > Math.abs(delta.y)) {
            dir.x = delta.x / Math.abs(delta.x);
            dir.y = 0;
        } else {
            dir.x = 0;
            dir.y = delta.y / Math.abs(delta.y);
        }

        // check if the path is clear
        var to = pos + dir * 16;
        var groups = [hash("tiles"), hash("objects"), hash("enemy")];
        var ray = Physics.raycast(pos, to, Table.fromArray(groups));

        if (ray != null) {
            if (Math.abs(dir.x) > Math.abs(dir.y)) {
                dir.x = 0;
                dir.y = Math.random(-1, 1);
            } else {
                dir.x = 0;
                dir.y = Math.random(-1, 1);
            }
        }

        return dir;
    }
}