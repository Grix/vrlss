///Rift_Init()

/* Attempts to initialize the rift and returns an error code if initialization should fail for some reason. */

global.RiftEyeHeight = 1.61;
global.DummySurface = -1;

var result, debugMessage;

//Pass D3D9 pointer and window handle to DLL 
RiftExt_SetWindow(window_handle());
result = RiftExt_Init(window_device());
switch( result )
{
    case 0:
        global.IsRiftInitialized = true;
        d3d_set_culling(true);
        d3d_set_hidden(true);
        d3d_set_perspective(false);
        application_surface_draw_enable(false);
        global.RightEyeProjectionMatrix = string_split_ext(RiftExt_GetEyeProjectionMatrix(1), " ");
        global.LeftEyeProjectionMatrix = string_split_ext(RiftExt_GetEyeProjectionMatrix(0), " ");        
        break;
    case 1:
        debugMessage = "Cannot initialize libOVR";
        break;
    case 2:
        debugMessage = "No rift detected";
        break;
    case 3:
        debugMessage = "No tracking available on HMD";
        break;
    case 4:
        debugMessage = "Failed to create d3d9 render target";
        break;
    case 5:
        debugMessage = "Failed to link shared resource with D3D11";
        break;
    case 6:
        debugMessage = "Failed to create depth buffer.";
        break;          
    default:
        debugMessage = "Other error";
        break;
}

if ( result != 0 && global.IsDebugMode )
{
    show_debug_message(debugMessage);
    game_end();
}

return result;