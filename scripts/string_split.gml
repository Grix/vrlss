///string_split( string )

var myString, i, output;

i = 0;
myString = argument0;

doContinue = true;
while(string_length(myString)> 0)
{
    var pos;
    
    pos = string_pos(",", myString);
    if ( pos == 0 )
    {
        output[i] = real(myString);
        myString = "";
    }
    else
    {
        output[i] = real(string_copy(myString, 1, pos-1));
        myString = string_delete(myString, 1, pos);
    }
    
    i++;
}

return output;
