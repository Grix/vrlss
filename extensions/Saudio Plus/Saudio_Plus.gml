#define saud_play
// saud_play(id)
// Play the media id
return MCI_command("play "+argument0)

#define saud_pause
// saud_pause(id)
// Pause the media id
return MCI_command("pause "+argument0)

#define saud_resume
// saud_resume(id)
// Resume the media id
return MCI_command("resume "+argument0)

#define saud_stop
// saud_stop(id)
// Stop the media id
return MCI_command("stop "+argument0)

#define saud_seek
// saud_seek(pos,id)
// Seek the media id to position pos
MCI_command("seek "+string(argument1)+" to "+string(argument0));
MCI_command("play "+argument1);//fix: when cant resume

#define saud_position
// saud_position(id)
// Get the current position of media id
return MCI_command("status "+argument0+" position")

#define saud_length
// saud_length(id)
// Get the length of media id
return MCI_command("status "+argument0+" length")

#define saud_close
// saud_close(id)
// Close the media id
return MCI_command("close "+argument0)

#define saud_load
// saud_load(path,id)
// Load a file from path and assign it an id
var dev, dev2, file, check, buffer, c, get_dev;
//Device
dev[1] = "MPEGVideo";//*(vista/seven)codec
dev[2] = "WaveAudio";//*.wav
dev[3] = "Sequencer";//*.mid
dev[4] = "AVIVideo";//*.avi
dev[5] = "DigitalVideo";//*video?
dev[6] = "Overlay";//*video?
dev[7] = "MMMovie";//*video?
dev[8] = "DAT";//*audio?
dev[9] = "Other";//*???

//file
file = argument0;

//c (counter)
c = 1;
get_dev = "ERROR";
check = 0;

do
{
buffer = MCI_command('open "'+file+'" type '+dev[c]+" alias SPLN");
MCI_command("close SPLN");
if real(buffer) >= 1
{
get_dev = dev[c];
check = 1;
}
c+=1;
}until (check = 1) or (c > 9)

//RETURN
dev2 = get_dev;
/*****/
if dev2!= "ERROR" 
{return MCI_command('open "'+argument0+'" type '+dev2+" style overlapped alias "+string(argument1))}
else {return -1;}

#define saud_status
// saud_status(id)
// Get the media id current status ( STOPPED / PAUSED / PLAYING / SEEKING / ect... )
return MCI_command("status "+argument0+" mode")

#define saud_can_play
// saud_can_play(id)
// Can the media id be played 

switch (MCI_command("capability "+argument0+" can play")) {
       
       case "true" : return true ;break;
       default : return false
       
}

#define saud_is_playing
// saud_is_playing(id)
// Return true if the media is playing
if ( string_lower(MCI_command("status "+argument0+" mode")) == "playing" ) 
{ return true } else { return false }

#define saud_is_paused
// saud_is_paused(id)
// Return true if the media is paused
if ( string_lower(MCI_command("status "+argument0+" mode")) == "paused" ) 
{ return true } else { return false }

#define saud_is_stopped
// saud_is_stopped(id)
// Return true if the media is stopped
if ( string_lower(MCI_command("status "+argument0+" mode")) == "stopped" ) 
{ return true } else { return false }

#define saud_set_global_volume
//saud_set_global_volume(vol,id)
MCI_command("setaudio "+string(argument1)+" volume to "+string(argument0))

#define saud_get_global_volume
//saud_get_global_volume(id)
MCI_command("status "+string(argument0)+" volume")

#define saud_set_volume_left
//saud_set_volume_left(vol,id)
MCI_command("setaudio "+string(argument1)+" left volume to "+string(argument0))

#define saud_get_volume_left
//saud_get_volume_left(id)
MCI_command("status "+string(argument0)+" left volume")

#define saud_set_volume_right
//saud_set_volume_right(vol,id)
MCI_command("setaudio "+string(argument1)+" right volume to "+string(argument0))

#define saud_get_volume_right
//saud_get_volume_right(id)
MCI_command("status "+string(argument0)+" right volume")

#define saud_movie_in
// saud_movie_in(id)
// Set the movie's window handle from GM Window
MCI_command("window "+argument0+" handle "+string(window_handle())+" notify")

#define saud_movie_out
// saud_movie_out(id)
// Set the movie's window handle from an external window
MCI_command("window "+argument0+" handle default notify")

#define saud_movie_set_rect
//saud_movie_set_rect(x,y,w,h,id)
MCI_command("put "+argument4+" destination at "+string(argument0)+" "+string(argument1)+" "+string(argument2)+" "+string(argument3))

#define saud_movie_set_caption
// saud_set_caption(text,id)
// If the movie is handled by an external window it will set the window's caption
MCI_command('window '+argument1+' text "'+string(argument0)+'"')

#define saud_has_movie
// saud_has_movie(id)
// Return true if the media id has a movie
return !( MCI_command("status "+argument0+" window handle") == ""  )

#define saud_movie_is_in
// saud_movie_is_in(id)
// Return true if the movie is on GM's window
return ( MCI_command("status "+argument0+" window handle") == string( window_handle() ) )

#define saud_movie_is_out
// saud_movie_is_out(id)
// Return true if the movie is not on GM's window
return !( MCI_command("status "+argument0+" window handle") == string( window_handle() ) )

#define saud_movie_window_handle
// saud_movie_window_handle(id)
// Get the media id's window handle
return MCI_command("status "+argument0+" window handle")

#define saud_set_speed
// saud_set_speed(speed,id)
MCI_command("set "+string(argument1)+" speed "+string(argument0))

#define saud_get_speed
// saud_get_speed(id)
MCI_command("status "+string(argument0)+" speed")

