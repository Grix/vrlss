///YPRToQuat( yaw, pitch, roll )

var c1, c2, c3, s1, s2, s3, c1c2, s1s2, result;

c1 = cos(-argument0/2);
c2 = cos(argument1/2);
c3 = cos(argument2/2);
s1 = sin(-argument0/2);
s2 = sin(argument1/2);
s3 = sin(argument2/2);
c1c2 = c1*c2;
s1s2 = s1*s2;

result[3] = c1*s2*c3 - s1*c2*s3;
result[2] = s1*c2*c3 + c1*s2*s3;
result[1] = c1c2*s3 + s1s2*c3;
result[0] = c1c2*c3 + s1s2*s3;

return result;
