///Rift_BeginEyeRender( layer, eye, useOculusTracking, red, green, blue, alpha )

/* Prepares the left eye surface for rendering.  

eye: the eye to start rendering to,  0 or 1 or  of enum tRiftEye definited in Init()
layer: the target layer
useOculusTracking: update with oculus positional information, else just use the cam, (should normally be set to true )
red, green, blue, alpha: the colors with which to clear the rendering surface

*/

if ( global.IsRiftInitialized )
{
    surface_set_target(global.DummySurface);
    RiftExt_BeginEyeRender(argument0, argument1, argument2, argument3, argument4, argument5, argument6);
    
    matrix_set(matrix_projection, RiftLayer_GetProjectionMatrix(argument0, argument1));
    matrix_set(matrix_view, RiftLayer_GetCurrentViewMatrix(argument0));
}
