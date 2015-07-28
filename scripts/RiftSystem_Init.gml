///RiftSystem_Init()

/* Initializes libOVR, the oculus rift routines.  If libOVR is initialized, the user has an
Oculus Rift */

if ( RiftExtSystem_Init() == -1 )
{
    global.HasRift = false;
}
else
{
    global.HasRift = true;
}