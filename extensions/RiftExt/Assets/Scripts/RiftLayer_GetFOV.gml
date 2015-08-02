///RiftLayer_GetFOV( layer, eye )

/* Gets an array that contains the FOV values for a layer and eye in the following order:
DownTan, LeftTan, RightTan, UpTan
*/


if ( global.IsRiftInitialized )
{
    var FOV;
    
    RiftExtLayer_GetFOV(argument0, argument1);
    buffer_seek(global.RiftVec4Buf, buffer_seek_start, 0);
    FOV[0] = buffer_read(global.RiftVec4Buf, buffer_f32);
    FOV[1] = buffer_read(global.RiftVec4Buf, buffer_f32);
    FOV[2] = buffer_read(global.RiftVec4Buf, buffer_f32);
    FOV[3] = buffer_read(global.RiftVec4Buf, buffer_f32);
    
    return FOV;
}
