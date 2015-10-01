///Rift_GetRiftYPR()

/* Returns an array that holds the yaw, pitch and roll of the Rift in that order. */

var resultStr, result;

if ( global.IsRiftInitialized )
{
    RiftExt_GetTrackingYPR();
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
