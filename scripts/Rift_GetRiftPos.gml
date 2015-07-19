///Rift_GetRiftPos()

/* Returns an array that holds the x, y and z coordinates of the Rift in that order. */

var resultStr, result;

if ( global.IsRiftInitialized )
{
    resultStr = RiftExt_GetRiftPos();
    result = string_split(resultStr);
}
else
{
    result[0] = 0;
    result[1] = 0;
    result[2] = 0;
}

return result;