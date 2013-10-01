/* Syntax: RF_ReadPart(file,start,count)

Arguments:
file - The filename of the file to read from.
start - The offset (in bytes) from the beginning of the file to start reading.
count - The number of bytes to read.

Returns: The part of "file" that begins at "start" and is "count" bytes
         long. Note that if this exceeds the length of the file, it will
         be padded on the right with NULL bytes, so GM will consider it,
         in most cases, truncated.
*/
var ret;
ret=external_call(global.__RFPart,argument0,argument1,argument2);
external_call(global.__RFFree);

return ret;
