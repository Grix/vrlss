///RiftLayer_GetEyeViewportSize( layer, eye )

/* Gets the viewport size for each eye and layer. */

var size;

if ( global.IsRiftInitialized )
{    
    RiftExtLayer_GetEyeViewportSize(argument0, argument1);
    buffer_seek(global.RiftVec2Buf, buffer_seek_start, 0);
    size[0] = buffer_read(global.RiftVec2Buf, buffer_f32);
    size[1] = buffer_read(global.RiftVec2Buf, buffer_f32);
}
else
{
    size[0] = -1;
    size[1] = -1;
}

return size;
