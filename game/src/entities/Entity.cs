using Godot;

public class Entity : KinematicBody2D
{
    Tween tween;
    RayCast2D raycast;

    public override void _Ready()
    {
        tween = GetNode<Tween>("Tween");
        raycast = GetNode<RayCast2D>("RayCast2D");
    }

    public override void _PhysicsProcess(float delta)
    {
        Vector2 moveDirection = GetMoveDirection();
        if (moveDirection.LengthSquared() == 1)
            Move();
    }

    private void Move()
    {
        SetPhysicsProcess(false);
        // Handle raycast to check if it can move
        // Make tween interpolate property
        // Start tween
        // Await for tween to finish
        SetPhysicsProcess(true);
    }

    protected virtual Vector2 GetMoveDirection()
    {
        return Vector2.Zero;
    }
}
