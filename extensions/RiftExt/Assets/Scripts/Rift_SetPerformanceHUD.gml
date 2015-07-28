///Rift_SetPerformanceHUD( mode )

/*
Displays or hides the Rift's performance HUD.  Values are:
0:  off
1:  latency timing
2:  render timing
*/

if ( global.IsRiftInitialized )
{
    RiftExt_SetPerformanceHUD(argument0);
}