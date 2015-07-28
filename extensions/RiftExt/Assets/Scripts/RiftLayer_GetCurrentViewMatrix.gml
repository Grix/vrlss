///RiftLayer_GetCurrentViewMatrix( layer )

/* Returns a 1d array[16] that represents the current 4x4 view matrix of the specified layer.
Must be called inside of BeginEyeRender/EndEyeRender. */

if ( global.IsRiftInitialized )
{
    return string_split_ext(RiftExtLayer_GetCurrentViewMatrix(argument0), " ");
}


