///Rift_GetRiftRot()

/* Returns an array that holds a rotation quaternion for the Rift in the order of 
w, x, y, z */

var resultStr, result;

if ( global.IsRiftInitialized )
{
    resultStr = RiftExt_GetTrackingRot();
    result = string_split(resultStr);
}
else
{
    result[0] = 0;
    result[1] = 0;
    result[2] = 0;
    result[3] = 0;
}

return result;