pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--sharepaint
--웃evs

function _init()
 menuitem(1,"save pixels",
  save_pixels
 )
 sx=7
 sy=7
 cx=0
 tx=0
 bottom_y=128
 mode=0
 outline=mget(16,0)==0 and 120 or 0
end

function _update()
 if mode==0 then
  if(btnp(⬅️))sx-=1
  if(btnp(➡️))sx+=1
  if(btnp(⬆️))sy-=1
  if(btnp(⬇️))sy+=1
  if(sx<0)sx=0
  if(sx>15)sx=15
  if(sy<0)sy=0
  if(sy>15)sy=15
  if btn(❎) then
   if tx==0 then
    mset(sx,sy,cx+32)
   elseif tx==1 then
    paint_bucket(sx,sy)
   end
  end
  if btnp()>0 then
   outline=0
  else
   outline+=1
  end
  if(bottom_y<128)bottom_y+=2
 elseif mode==1 then
  if(bottom_y>120)bottom_y-=2
  if(btnp(⬅️))cx-=1
  if(btnp(➡️))cx+=1
  if(cx<0)cx=15
  if(cx>15)cx=0
 elseif mode==2 then
  if(bottom_y>120)bottom_y-=2
  if(btnp(⬅️))tx-=1
  if(btnp(➡️))tx+=1
  if(tx<0)tx=1
  if(tx>1)tx=0
 end
 if btnp(🅾️) then
  mode+=1
  if(mode>2)mode=0
  outline=0
 end
end

function _draw()
 cls()
 palt(0,false)
 map(0,0,0,0,16,16)
 palt()
 if mode==0 then
  if(outline<120)drw_slct(sx,sy)
 end
 if bottom_y<128 then
  palt(0,false)
  for i=0,15 do
   spr(i+32+16*(mode-1),i*8,bottom_y)
  end
  palt(0,true)
  if mode>0 then
   local x=cx
   local sc
   if mode==2 then
    x=tx
    sc=8
   end
   if(bottom_y==120)drw_slct(x,15,sc)
  end
 end
end

function drw_slct(mx,my,c)
 local x=mx*8
 local y=my*8
 -- white if bg is dark,
 -- black if bg is light
 local bgcol=pget(x,y)
 local whiteish=is_whiteish_col(bgcol)
 c=c or (whiteish and 0 or 7)
 pal(7,c)
 spr(1,x,y)
 pal()
end

function save_pixels()
 local output=""
 local current_col=-1
 local current_count=0
 for y=0,15 do
  for x=0,15 do
   local col=mget(x,y)
   if col!=current_col then
    if current_count>1 then
     output..=tostr(current_count)
    end
    current_count=1
    current_col=col
    local letter=col_to_letter(col)
    output..=letter
   else
    current_count+=1
   end
  end
 end
 printh(output,"@clip")
end

function col_to_letter(c)
 return chr(c + 65)
end

function is_whiteish_col(c)
 return c==6
     or c==7
     or c==10
     or c==15
end

function paint_bucket(x,y)
 local startc=mget(x,y)
 local endc=cx+32
 flood_fill(x,y,startc,endc)
end

function flood_fill(x,y,sc,ec)
 if(x<0 or x>15)return
 if(y<0 or y>15)return
 local curr=mget(x,y)
 if(curr!=sc or curr==ec)return

 mset(x,y,ec)

 flood_fill(x+1,y,sc,ec)
 flood_fill(x,y+1,sc,ec)
 flood_fill(x-1,y,sc,ec)
 flood_fill(x,y-1,sc,ec)
end
__gfx__
00000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000111111112222222233333333444444445555555566666666777777778888888899999999aaaaaaaabbbbbbbbccccccccddddddddeeeeeeeeffffffff
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777700000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777770000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07077770007777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07007700070777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222eeeeeeeeeeeeeeee22222222222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7777777777777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
2222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee77777777eeeeeeeeeeeeeeee2222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
222222222222222222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
22222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
2222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee22222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
222222222222222222222222222222222222222288888888eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee888888882222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222288888888888888888888888888888888222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222

__map__
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
