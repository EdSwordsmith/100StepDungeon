package buttons;

import defold.Sprite.SpriteMessages;
import defold.Sprite.SpriteMessagePlayAnimation;
import defold.Msg;
import haxe.macro.Expr.Case;
import modules.Interact;
import defold.types.Message;
import defold.types.Url;
import defold.types.Hash;
import defold.support.Script;

typedef ButtonData = {
    var event:Hash;
    var texture:String;
    var on:Bool;
}

class Button extends Script<ButtonData> {
    private function getAnimation(self:ButtonData) {
        var status = "-on";
        if (!self.on) status = "-off";

        return Defold.hash(self.texture + status);
    }

    override function on_message<T>(self:ButtonData, message_id:Message<T>, message:T, sender:Url) {
        switch (message_id) {
            case Interact.INTERACT:
                self.on = !self.on;
                Msg.post("#sprite", SpriteMessages.play_animation, { id: getAnimation(self) });
                //Msg.post(self.event, "handle_event");
        }
    }
}