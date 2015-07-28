///RiftLayer_GetEyeViewportSize( layer, eye )

/* Gets the viewport size for each eye and layer. */

var sizeStr, size;

if ( global.IsRiftInitialized )
{
    sizeStr = RiftExtLayer_GetEyeViewportSize(argument0, argument1);
    size = string_split(sizeStr);
}
else
{
    size[0] = -1;
    size[1] = -1;
}

return size;
