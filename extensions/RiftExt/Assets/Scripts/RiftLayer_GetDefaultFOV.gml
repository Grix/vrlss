///RiftLayer_GetDefaultFOV( layer, eye )

/* Gets an array that contains the default FOV values for a layer and eye in the following order:
DownTan, LeftTan, RightTan, UpTan
*/


if ( global.IsRiftInitialized )
{
    var FOV;
    
    FOV = string_split(RiftExtLayer_GetDefaultFOV(argument0, argument1));
    return FOV;
}
