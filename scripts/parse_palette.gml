#define parse_palette
show_message("This ilda format requires a color palette, please load it. (NB: support limited, it's recommended to convert to ilda format 4 or 5 instead)");
file = file_text_open_read(get_open_filename("*.txt",""));
noc = file_text_read_real(file);
palette_grid = ds_grid_create(3,noc);
i = 0;
n = 0;
l = 0;
while (i < noc)
    {
    file_text_readln(file);
    ds_grid_set(palette_grid,n,l,file_text_read_real(file));
    if (n = 2)
        {
        n = 0;
        l++;
        }
    else n++;
    i++;
    }
file_text_close(file);