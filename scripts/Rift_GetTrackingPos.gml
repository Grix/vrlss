///Rift_GetRiftPos()

/* Returns an array that holds the x, y and z coordinates of the Rift in that order. */

var result;

if ( global.IsRiftInitialized )
{
    RiftExt_GetTrackingPos();
    buffer_seek(global.RiftVec3Buf, buffer_seek_start, 0);
    result[0] = buffer_read(global.RiftVec3Buf, buffer_f32);
    result[1] = buffer_read(global.RiftVec3Buf, buffer_f32);
    result[2] = buffer_read(global.RiftVec3Buf, buffer_f32);
}
else
{
    result[0] = 0;
    result[1] = 0;
    result[2] = 0;
}

return result;