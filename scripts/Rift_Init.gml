///Rift_Init()

/* Attempts to initialize the rift and returns an error code if initialization should fail for some reason. */

if ( global.HasRift )
    {
    global.RiftEyeHeight = 1.8;
    global.DummySurface = -1;
    
    var result, debugMessage;
    
    //Pass D3D9 pointer and window handle to DLL 
    Window_SetWindow(window_handle());
    result = RiftExt_Init(window_device());
    
    if ( result != -1 )
        {
        application_surface_draw_enable(false);
        global.IsRiftInitialized = true;
        d3d_set_culling(0);
        d3d_set_hidden(0);
        d3d_set_perspective(0);
        }
    else
        {
        if ( global.IsDebugMode )
            { show_message(RiftExtError_GetLast()); }
        
        //game_end();
        end3D();
        room_goto(rm_2d);
        }   
    
    return result;
    }

return -1;