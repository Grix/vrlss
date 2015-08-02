///Rift_GetRiftRot()

/* Returns an array that holds a rotation quaternion for the Rift in the order of 
w, x, y, z */

var result;

if ( global.IsRiftInitialized )
{    
    RiftExt_GetTrackingRot();
    buffer_seek(global.RiftVec4Buf, buffer_seek_start, 0);
    result[0] = buffer_read(global.RiftVec4Buf, buffer_f32);
    result[1] = buffer_read(global.RiftVec4Buf, buffer_f32);
    result[2] = buffer_read(global.RiftVec4Buf, buffer_f32);
    result[3] = buffer_read(global.RiftVec4Buf, buffer_f32);
}
else
{
    result[0] = 0;
    result[1] = 0;
    result[2] = 0;
    result[3] = 0;
}

return result;