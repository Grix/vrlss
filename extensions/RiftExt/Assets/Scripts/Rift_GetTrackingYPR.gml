///Rift_GetRiftYPR()

/* Returns an array that holds the yaw, pitch and roll of the Rift in that order. */

var resultStr, result;

if ( global.IsRiftInitialized )
{
    resultStr = RiftExt_GetTrackingYPR();
    result = string_split(resultStr);
}
else
{
    result[0] = 0;
    result[1] = 0;
    result[2] = 0;
}

return result;