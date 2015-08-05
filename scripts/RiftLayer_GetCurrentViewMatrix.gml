///RiftLayer_GetCurrentViewMatrix( layer )

/* Returns a 1d array[16] that represents the current 4x4 view matrix of the specified layer.
Must be called inside of BeginEyeRender/EndEyeRender. */

if ( global.IsRiftInitialized )
{
    RiftExtLayer_GetCurrentViewMatrix(argument0);

    var result, i;
    buffer_seek(global.RiftMatrixBuf, buffer_seek_start, 0);
    for( i = 0; i < 16; ++i )
    {
        result[i] = buffer_read(global.RiftMatrixBuf, buffer_f32);
    }
    
    return result;
}