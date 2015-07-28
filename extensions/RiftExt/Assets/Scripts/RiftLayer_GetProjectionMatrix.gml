///RiftLayer_GetProjectionMatrix( layer, eye )

/* Returns a 1d array[16] that represents the current 4x4 projection matrix of the specified layer and eye.
 */

if ( global.IsRiftInitialized )
{
    return string_split_ext(RiftExtLayer_GetProjectionMatrix(argument0, argument1), " ");
}


