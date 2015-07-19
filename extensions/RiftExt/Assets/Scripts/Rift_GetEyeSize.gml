///Rift_GetEyeSize( eye )

/* Gets the texture size required for each eye. */

var sizeStr, size;

if ( global.IsRiftInitialized )
{
    sizeStr = RiftExt_GetEyeSize(argument0);
    size = string_split(sizeStr);
}
else
{
    size[0] = -1;
    size[1] = -1;
}

return size;