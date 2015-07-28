///RiftLayer_SetFOV(layer, leftDownTan, leftLeftTan, leftRightTan, leftUpTan, rightDownTan, rightLeftTan, rightRightTan, rightUpTan )

/* Sets the FOV for the left and right eye of the specified layer. */

if ( global.IsRiftInitialized )
{
    RiftExtLayer_SetFOV(argument0, argument1, argument2, argument3, argument4, 
            argument5, argument6, argument7, argument8);
}