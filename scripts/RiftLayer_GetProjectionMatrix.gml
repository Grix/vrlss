///RiftLayer_GetProjectionMatrix( layer, eye )

/* Returns a 1d array[16] that represents the current 4x4 projection matrix of the specified layer and eye.
 */

if ( global.IsRiftInitialized )
{
    RiftExtLayer_GetProjectionMatrix(argument0, argument1);

    var result, i;
    buffer_seek(global.RiftMatrixBuf, buffer_seek_start, 0);
    for( i = 0; i < 16; ++i )
    {
        result[i] = buffer_read(global.RiftMatrixBuf, buffer_f32);
    }
    
    return result;
}