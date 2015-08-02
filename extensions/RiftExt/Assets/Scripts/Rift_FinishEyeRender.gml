///Rift_EndRenderRightEye()

/* Ends rendering of the current eye. */

if ( global.IsRiftInitialized )
{
    surface_reset_target(); 
    RiftExt_FinishEyeRender(); 
}