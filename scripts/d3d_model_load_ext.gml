/*  d3d_model_load_ext - 3D MODELS IMPORTER SCRIPT
    by Paul "Masterxilo" Frischknecht 2006 - 2010 (c). All rights reserved, see the ReadMe.txt and Game Information of this gmk.

    supports *.mod;*.vtx;*.obj;*.asc;*.c;*.x (only not compressed "text" file);

    Syntax: 
        d3d_model_load_ext(ind,fname,flipnormals,fliptexcoords,scale)

    Info:
        The model ("ind") must already be created like for d3d_model_load()
        
        "scale" is useful because the d3d_transform_add_scaling(xy,ys,zs) destroys the normals while this doesn't.
        
        "scale", "flipnormals" and "fliptexcoords" don't affect *.mod files (these are loaded using the builtin d3d_model_load())
        
        "fliptexcoords" flips the texture coordinates y/v values (often needed because of the way gm3d applies textures)

    Created global debug variables:
        "global.dmle_vertices" - Amount of vertices loaded (not working for GM .mod models)
        "global.dmle_time"     - Time (in milliseconds) needed to load the model
*/


// Implementation (code not cleaned up...)
global.dmle_vertices=0
global.dmle_time=0

var flipnormals,fliptex,cur_milisec;
flipnormals=1
if(argument2)flipnormals=-1
fliptex=argument3
scale=argument4
cur_milisec=current_time
global.dmle_vertices=0

if(string_count(".mod",argument1)>0)d3d_model_load(argument0,argument1);

if(string_count(".vtx",argument1)>0) 
    {
    var str,file,row,data,i,tex_y,temp,t;
    file=file_text_open_read(argument1);
    data=ds_list_create();
    row=""
    do
        {
        if!(string_count(".Vertex",row)=1)
            {
            do {row=file_text_read_string(file);file_text_readln(file)}
            until string_count(".Vertex",row)=1
            }
    
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("// end of .Vertex",row)=0)
                {
                str=string_copy(row,1,string_pos(" ",row)-1)
                row=string_delete(row,1,string_pos(" ",row)-1)
                ds_list_add(data,real(str))
                repeat((3-1)+3+(2-1))
                    {
                    row=string_delete(row,1,1)
                    str=string_copy(row,1,string_pos(" ",row)-1)
                    row=string_delete(row,1,string_pos(" ",row)-1)
                    ds_list_add(data,real(str))
                    }
                row=string_delete(row,1,1)
                str=string_copy(row,1,string_length(row))
                ds_list_add(data,real(str))
                }
            }
        until string_count("// end of .Vertex",row)=1

        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count(".Index",row)=1

        do
            {
            d3d_model_primitive_begin(argument0,pr_trianglelist)
            
            row=file_text_read_string(file);file_text_readln(file)
            
            if(string_count("// end if .Index",row)=0)
                {
                t=0
                repeat(3)
                    {
                    str=string_copy(row,1,string_pos(" ",row)-1)
                    row=string_delete(row,1,string_pos(" ",row))
                    temp[t]=real(str)
                    t+=1
                    }
                t=2
                repeat(3)
                    {
                    i=temp[t]*8
                    tex_y=ds_list_find_value(data,i+7)
                    if(fliptex)tex_y=1-tex_y
                    
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(data,i+0)*scale,ds_list_find_value(data,i+1)*scale,ds_list_find_value(data,i+2)*scale
                                                            ,flipnormals*ds_list_find_value(data,i+3),flipnormals*ds_list_find_value(data,i+4),flipnormals*ds_list_find_value(data,i+5)
                                                            ,ds_list_find_value(data,i+6),tex_y);global.dmle_vertices+=1;
                    t-=1
                    }
                d3d_model_primitive_end(argument0)
                d3d_model_primitive_begin(argument0,pr_trianglelist)
                }
            }
        until string_count("// end if .Index",row)=1

        d3d_model_primitive_end(argument0)
        ds_list_clear(data);
    
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("// end of .Brdf",row)=1
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count(".Vertex",row)=1||string_count("// End of file",row)=1
        }
    until string_count("// End of file",row)=1||file_text_eof(file)
    file_text_close(file);
    ds_list_destroy(data);
    }
    
if(string_count(".obj",argument1)>0) 
    {
    var str,file,row,tex_y,v_x,v_y,v_z,n_x,n_y,n_z,u,v,i,numb,edges,faces,t,p_count;
    file=file_text_open_read(argument1);
    v_x=ds_list_create();ds_list_add(v_x,0);
    v_y=ds_list_create();ds_list_add(v_y,0);
    v_z=ds_list_create();ds_list_add(v_z,0);
    n_x=ds_list_create();ds_list_add(n_x,0);
    n_y=ds_list_create();ds_list_add(n_y,0);
    n_z=ds_list_create();ds_list_add(n_z,0);
    u=ds_list_create();ds_list_add(u,0);
    v=ds_list_create();ds_list_add(v,0);
    row=""
    
    do
        {
        if(string_count("v ",row)=0)
           {
           do {row=file_text_read_string(file);file_text_readln(file)}
           until string_char_at(row,1)="v"&&string_char_at(row,2)=" "
           }
    
        do 
            {
            row=string_delete(row,1,string_pos(" ",row));
            str=string_copy(row,1,string_pos(" ",row)-1); 
            row=string_delete(row,1,string_pos(" ",row));
            ds_list_add(v_x,real(str));
            str=string_copy(row,1,string_pos(" ",row)-1) 
            row=string_delete(row,1,string_pos(" ",row));
            ds_list_add(v_y,real(str));
            str=string_copy(row,1,string_length(row)) 
            ds_list_add(v_z,real(str));
            row=file_text_read_string(file);file_text_readln(file)
            }
        until string_count("v ",row)=0
        
        do {row=file_text_read_string(file);file_text_readln(file)}
        until (string_char_at(row,1)="v"&&string_char_at(row,2)="n")||(string_char_at(row,1)="v"&&string_char_at(row,2)="t")||(string_char_at(row,1)="f"&&string_char_at(row,2)=" ")

        if(string_count("vn ",row)=1)
            {
            do 
                {
                row=string_delete(row,1,string_pos(" ",row));
                str=string_copy(row,1,string_pos(" ",row)-1); 
                row=string_delete(row,1,string_pos(" ",row));
                ds_list_add(n_x,real(str));
                str=string_copy(row,1,string_pos(" ",row)-1) 
                row=string_delete(row,1,string_pos(" ",row));
                ds_list_add(n_y,real(str));
                str=string_copy(row,1,string_length(row)) 
                ds_list_add(n_z,real(str)); 
                row=file_text_read_string(file);file_text_readln(file) 
                }
            until string_count("vn ",row)=0
            }
                
        if(string_count("vt ",row)=0)
           {
            do {row=file_text_read_string(file);file_text_readln(file)}
            until (string_char_at(row,1)="v"&&string_char_at(row,2)="t")||(string_char_at(row,1)="f"&&string_char_at(row,2)=" ")
            }
        
        if(string_count("vt ",row)=1)
            {
            do 
                {
                row=string_delete(row,1,string_pos(" ",row));
                str=string_copy(row,1,string_pos(" ",row)-1); 
                row=string_delete(row,1,string_pos(" ",row));
                ds_list_add(u,real(str));
                str=string_copy(row,1,string_length(row)) 
                ds_list_add(v,real(str));
                row=file_text_read_string(file);file_text_readln(file) 
                }
            until string_count("vt ",row)=0
            }
        if(string_count("f ",row)=0)
           {
           do {row=file_text_read_string(file);file_text_readln(file)}
           until (string_char_at(row,1)="f"&&string_char_at(row,2)=" ")
           }
 
  
        pos=0
        do
            {
            d3d_model_primitive_begin(argument0,pr_trianglelist)
            
            row=string_delete(row,1,string_pos(" ",row));
            row=string_replace_all(row,"//","/0/");
            
            str=string_copy(row,1,string_pos(" ",row)-1); 
            p_count=string_count("/",str)
            if(p_count!=2)row=string_replace_all(row," ","/0 ");
            
            if(string_char_at(row,string_length(row))=" ")row=string_copy(row,1,string_length(row)-1)
            
            edges=string_count(" ",row)+1
            for(t=0;t<edges;t+=1)
                {
                str=string_copy(row,1,string_pos("/",row)-1); 
                row=string_delete(row,1,string_pos("/",row));
                faces[t,0]=real(str);

                str=string_copy(row,1,string_pos("/",row)-1); 
                row=string_delete(row,1,string_pos("/",row));
                faces[t,1]=real(str);

            if!(t=edges-1)
                {
                str=string_copy(row,1,string_pos(" ",row)-1); 
                row=string_delete(row,1,string_pos(" ",row));
                }
                else str=string_copy(row,1,string_length(row)); 
            faces[t,2]=real(str);
            }
            //build faces
            if(edges<=3)
                {
                for(t=0;t<edges;t+=1)
                    {
                    tex_y=ds_list_find_value(v,faces[t,1])
                    if(fliptex)tex_y=1-tex_y
                    //show_error(string(ds_list_find_value(v_x,faces[t,0]))+";"+string(ds_list_find_value(v_y,faces[t,0]))+";"+string(ds_list_find_value(v_z,faces[t,0]))+";",false)
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[t,0])*scale,ds_list_find_value(v_y,faces[t,0])*scale,ds_list_find_value(v_z,faces[t,0])*scale
                                                         ,flipnormals*ds_list_find_value(n_x,faces[t,2]),flipnormals*ds_list_find_value(n_y,faces[t,2]),flipnormals*ds_list_find_value(n_z,faces[t,2])
                                                         ,ds_list_find_value(u,faces[t,1]),tex_y);global.dmle_vertices+=1;
                    }
                }
            else
                {

                for(t=2;t<edges;t+=1)
                    {
                    tex_y=ds_list_find_value(v,faces[0,1])
                    if(fliptex)tex_y=1-tex_y
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[0,0])*scale,ds_list_find_value(v_y,faces[0,0])*scale,ds_list_find_value(v_z,faces[0,0])*scale,flipnormals*ds_list_find_value(n_x,faces[0,2]),flipnormals*ds_list_find_value(n_y,faces[0,2]),flipnormals*ds_list_find_value(n_z,faces[0,2]),ds_list_find_value(u,faces[0,1]),tex_y);global.dmle_vertices+=1;
                    tex_y=ds_list_find_value(v,faces[t-1,1])
                    if(fliptex)tex_y=1-tex_y
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[t-1,0])*scale,ds_list_find_value(v_y,faces[t-1,0])*scale,ds_list_find_value(v_z,faces[t-1,0])*scale,flipnormals*ds_list_find_value(n_x,faces[t-1,2]),flipnormals*ds_list_find_value(n_y,faces[t-1,2]),flipnormals*ds_list_find_value(n_z,faces[t-1,2]),ds_list_find_value(u,faces[t-1,1]),tex_y);global.dmle_vertices+=1;
                    tex_y=ds_list_find_value(v,faces[t,1])
                    if(fliptex)tex_y=1-tex_y
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[t,0])*scale,ds_list_find_value(v_y,faces[t,0])*scale,ds_list_find_value(v_z,faces[t,0])*scale,flipnormals*ds_list_find_value(n_x,faces[t,2]),flipnormals*ds_list_find_value(n_y,faces[t,2]),flipnormals*ds_list_find_value(n_z,faces[t,2]),ds_list_find_value(u,faces[t,1]),tex_y);global.dmle_vertices+=1;
                    }
                }
            d3d_model_primitive_end(argument0)
            d3d_model_primitive_begin(argument0,pr_trianglelist)   

            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("f ",row)=0)
                {
                do {row=file_text_read_string(file);file_text_readln(file)}
                until (string_char_at(row,1)="f"&&string_char_at(row,2)=" ")||(string_char_at(row,1)="v"&&string_char_at(row,2)=" ")||file_text_eof(file);
                }
            }
        until string_count("f ",row)=0 
        
        d3d_model_primitive_end(argument0)
        while !(string_count("v ",row)=1||file_text_eof(file)) {row=file_text_read_string(file);file_text_readln(file)}
        }
    until file_text_eof(file);
           
    file_text_close(file);
    ds_list_destroy(v_x);ds_list_destroy(v_y);ds_list_destroy(v_z);
    ds_list_destroy(n_x);ds_list_destroy(n_y);ds_list_destroy(n_z);
    ds_list_destroy(u);ds_list_destroy(v);
    }

if(string_count(".x",argument1)>0) 
    {
    var str,file,row,tex_y,v_x,v_y,v_z,n_x,n_y,n_z,u,v,i,numb_faces,edges,faces,t,p_count;
    file=file_text_open_read(argument1);
    v_x=ds_list_create();
    v_y=ds_list_create();
    v_z=ds_list_create();    
    n_x=ds_list_create();
    n_y=ds_list_create();
    n_z=ds_list_create();
    u=ds_list_create();
    v=ds_list_create();
    row=""
    
    do
        {
        if!(string_count("Mesh {",row)=1)
            {
            do {row=file_text_read_string(file);file_text_readln(file)}
            until string_count("Mesh {",row)=1
            }
        row=file_text_read_string(file);file_text_readln(file);//don't read numb of vertexes    
        do
            {
            row=file_text_read_string(file);file_text_readln(file)

                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(v_x,real(str))
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(v_y,real(str))
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(v_z,real(str))
                

            }
        until string_count(";",row)=1
        
        row=file_text_read_string(file);file_text_readln(file);
        numb_faces=real(string_digits(row))
        t=0
        do
            {
            row2=file_text_read_string(file);file_text_readln(file)

                row=string_replace_all(row2," ","")
                row=string_replace_all(row,";;",",;;")
                
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                faces[t,0]=real(str)
                for(i=1;i<=faces[t,0];i+=1)
                    {
                    str=string_copy(row,1,string_pos(",",row)-1)
                    row=string_delete(row,1,string_pos(",",row))
                    faces[t,i]=real(string_digits(str))
                    }
                t+=1
            }        
        until string_count(";;",row2)=1  
                   
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("MeshNormals {",row)=1
        
        row=file_text_read_string(file);file_text_readln(file);//don't read numb of normals
        
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(n_x,real(str))
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(n_y,real(str))
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(n_z,real(str))

            }
        until string_count(";",row)=1

        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("MeshTextureCoords {",row)=1
        
        row=file_text_read_string(file);file_text_readln(file);//don't read numb of MeshTextureCoords 
        
        do
            {
            row=file_text_read_string(file);file_text_readln(file)

                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(u,real(str))
                str=string_copy(row,1,string_pos(";",row)-1)
                row=string_delete(row,1,string_pos(";",row))
                ds_list_add(v,real(str))

            }
        until string_count(";",row)=1
        
        for(i=0;i<numb_faces;i+=1)
            {
            d3d_model_primitive_begin(argument0,pr_trianglelist)
            t=1
            for(t=1;t<=faces[i,0];t+=1)
                {
                tex_y=ds_list_find_value(v,faces[i,t])
                if(fliptex)tex_y=1-tex_y
                //show_error(string(ds_list_find_value(v_x,faces[t,0]))+";"+string(ds_list_find_value(v_y,faces[t,0]))+";"+string(ds_list_find_value(v_z,faces[t,0]))+";",false)
                d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[i,t])*scale,ds_list_find_value(v_y,faces[i,t])*scale,ds_list_find_value(v_z,faces[i,t])*scale
                                                        ,flipnormals*ds_list_find_value(n_x,faces[i,t]),flipnormals*ds_list_find_value(n_y,faces[i,t]),flipnormals*ds_list_find_value(n_z,faces[i,t])
                                                        ,ds_list_find_value(u,faces[i,t]),tex_y);global.dmle_vertices+=1;
                }
            d3d_model_primitive_end(argument0)      
            }
        
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("Mesh {",row)=1||file_text_eof(file)
    
        ds_list_clear(v_x);ds_list_clear(v_y);ds_list_clear(v_z);
        ds_list_clear(n_x);ds_list_clear(n_y);ds_list_clear(n_z);
        ds_list_clear(u);ds_list_clear(v);
        }
    until file_text_eof(file)

    
    file_text_close(file);
    ds_list_destroy(v_x);ds_list_destroy(v_y);ds_list_destroy(v_z);
    ds_list_destroy(n_x);ds_list_destroy(n_y);ds_list_destroy(n_z);
    ds_list_destroy(u);ds_list_destroy(v);
    }
    
if(string_count(".c",argument1)>0) 
    {
    var str,file,row,tex_y,v_x,v_y,v_z,n_x,n_y,n_z,u,v,i,numb,edges,faces,t,p_count;
    file=file_text_open_read(argument1);
    v_x=ds_list_create();
    v_y=ds_list_create();
    v_z=ds_list_create();    
    n_x=ds_list_create();
    n_y=ds_list_create();
    n_z=ds_list_create();
    u=ds_list_create();
    v=ds_list_create();
    row=""
    
    do
        {
        if!(string_count("_coords[]",row)=1)
            {
            do {row=file_text_read_string(file);file_text_readln(file)}
            until string_count("_coords[]",row)=1
            }
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("};",row)=0)
                {
                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(v_x,real(str))
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(v_y,real(str))
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(v_z,real(str))
                }
            }
        until string_count("};",row)=1
    
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("_normals[]",row)=1
    
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("};",row)=0)
                {
                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(n_x,real(str))
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(n_y,real(str))
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(n_z,real(str))
                }
            }
        until string_count("};",row)=1
    
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("_texcoords[]",row)=1
    
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("};",row)=0)
                {
                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(u,real(str))
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                ds_list_add(v,real(str))
                }
            }
        until string_count("};",row)=1
 
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("_indices[]",row)=1
    
        do
            {
            d3d_model_primitive_begin(argument0,pr_trianglelist)
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("};",row)=0)
                {
                row=string_replace_all(row," ","")
            
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                faces[0]=real(str)
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                faces[1]=real(str)
                str=string_copy(row,1,string_pos(",",row)-1)
                row=string_delete(row,1,string_pos(",",row))
                faces[2]=real(str)
                i=0
                repeat(3)
                    {
                    tex_y=ds_list_find_value(v,faces[i])
                    if(fliptex)tex_y=1-tex_y
                    d3d_model_vertex_normal_texture(argument0,ds_list_find_value(v_x,faces[i])*scale,ds_list_find_value(v_y,faces[i])*scale,ds_list_find_value(v_z,faces[i])*scale
                                                            ,flipnormals*ds_list_find_value(n_x,faces[i]),flipnormals*ds_list_find_value(n_y,faces[i]),flipnormals*ds_list_find_value(n_z,faces[i])
                                                            ,ds_list_find_value(u,faces[i]),tex_y);global.dmle_vertices+=1;
                    i+=1    
                    }
                }
            d3d_model_primitive_end(argument0)
            }
        until string_count("};",row)=1
    
        do {row=file_text_read_string(file);file_text_readln(file)}
        until string_count("_coords[]",row)=1||string_count("// End of file",row)=1
    
        ds_list_clear(v_x);ds_list_clear(v_y);ds_list_clear(v_z);
        ds_list_clear(n_x);ds_list_clear(n_y);ds_list_clear(n_z);
        ds_list_clear(u);ds_list_clear(v);
        }
    until string_count("// End of file",row)=1||file_text_eof(file)

    
    file_text_close(file);
    ds_list_destroy(v_x);ds_list_destroy(v_y);ds_list_destroy(v_z);
    ds_list_destroy(n_x);ds_list_destroy(n_y);ds_list_destroy(n_z);
    ds_list_destroy(u);ds_list_destroy(v);
    }
    
if(string_count(".asc",argument1)>0) 
    {
    var str,file,row,tex_y,v_x,v_y,v_z,i,numb,edges,faces,t,p_count;
    file=file_text_open_read(argument1);
    v_x=ds_list_create();
    v_y=ds_list_create();
    v_z=ds_list_create();    
    row=""
    
    do
        {
        if(string_count("Vertex list:",row)=0)
            {
            do {row=file_text_read_string(file);file_text_readln(file)}
            until string_count("Vertex list:",row)=1
            }
        
        do
            {
            row=file_text_read_string(file);file_text_readln(file)
            if(string_count("Face list:",row)=0)
                {
                row=string_delete(row,1,string_pos(":",row))
                row=string_delete(row,1,string_pos(":",row))
                row=string_replace_all(row," ","")
                row=string_replace_all(row,"Y","")
                row=string_replace_all(row,"Z","")
                row+=":"
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                ds_list_add(v_x,real(str))
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                ds_list_add(v_y,real(str))
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                ds_list_add(v_z,real(str))
                }
            }
        until string_count("Face list:",row)=1
        
        do
            {
            row2=file_text_read_string(file);file_text_readln(file)
            if(string_count("Face",row2)=1)
                {
                d3d_model_primitive_begin(argument0,pr_trianglelist)
                row=string_delete(row2,1,string_pos("A:",row2)+1)
                row=string_copy(row,1,string_pos("AB",row)-1)
                row=string_replace_all(row," ","")
                row=string_replace_all(row,"B","")
                row=string_replace_all(row,"C","")
                row+=":"
                
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                t=real(str)
                d3d_model_vertex(argument0,ds_list_find_value(v_x,t)*scale,ds_list_find_value(v_y,t)*scale,ds_list_find_value(v_z,t)*scale)global.dmle_vertices+=1;
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                t=real(str)
                d3d_model_vertex(argument0,ds_list_find_value(v_x,t)*scale,ds_list_find_value(v_y,t)*scale,ds_list_find_value(v_z,t)*scale)global.dmle_vertices+=1;
                str=string_copy(row,1,string_pos(":",row)-1)
                row=string_delete(row,1,string_pos(":",row))
                t=real(str)
                d3d_model_vertex(argument0,ds_list_find_value(v_x,t)*scale,ds_list_find_value(v_y,t)*scale,ds_list_find_value(v_z,t)*scale)global.dmle_vertices+=1;
                d3d_model_primitive_end(argument0)
                }
            }
        until (string_count("Face",row2)=0&&string_count("Smoothing",row2)=0)||file_text_eof(file)
        
        while !(string_count("Vertex list:",row)=1||file_text_eof(file)){row=file_text_read_string(file);file_text_readln(file)}
        ds_list_clear(v_x);ds_list_clear(v_y);ds_list_clear(v_z);
        }
    until file_text_eof(file) 
    
    ds_list_destroy(v_x);ds_list_destroy(v_y);ds_list_destroy(v_z);
    file_text_close(file);
    }
    
global.dmle_time=abs(current_time-cur_milisec)