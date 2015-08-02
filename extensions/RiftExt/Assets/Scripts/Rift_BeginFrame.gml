///Rift_BeginFrame()

/* Prepares the rift for rendering.  After calling this, all subsequent draw calls should be placed between the EyeRender
functions, until Rift_ShowFrame is called */

if ( global.IsRiftInitialized )
{
    var result, projView;
    
    if ( !surface_exists(global.DummySurface) )
    {
        global.DummySurface = surface_create(1,1); 
    }
    
    RiftExt_BeginFrame(); 

}

