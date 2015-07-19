///Rift_StartFrame()

/* Prepares the rift for rendering.  After calling this, all subsequent draw calls should be placed between the EyeRender
functions, until Rift_ShowFrame is called */

if ( global.IsRiftInitialized )
{
    var result, size, projView;
    
    size = Rift_GetEyeSize(0);
    if ( !surface_exists(global.DummySurface) )
    {
        global.DummySurface = surface_create(1,1); 
    }
    
    RiftExt_StartFrame(); 
}










