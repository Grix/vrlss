///RiftLayer_GetFOV( layer, eye )

/* Gets an array that contains the FOV values for a layer and eye in the following order:
DownTan, LeftTan, RightTan, UpTan
*/


if ( global.IsRiftInitialized )
{
    var FOV;
    
    FOV = string_split(RiftExtLayer_GetFOV(argument0, argument1));
    return FOV;
}