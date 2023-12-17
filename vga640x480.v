`timescale 1ns / 1ps

module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input wire [9:0] bird_coord,
	input wire [8:0] pipe_pos,
	input wire [7:0]pipe_array0,
	input wire [7:0]pipe_array1,
	input wire [3:0] current_score,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue,	//blue vga output
	input jumprate1,
	input jumprate2,
	input jumprate3,
	input [1:0] state
	);
//these are just the gameover parameters but for some reason not working rn.
parameter [7:0] G = 8'b11111000;
parameter [7:0] A = 8'b10001000;
parameter [7:0] M = 8'b10101000;
parameter [7:0] E = 8'b10011000;
parameter [7:0] O = 8'b11111000;
parameter [7:0] V = 8'b11111000;
parameter [7:0] R = 8'b10101000;

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// this is for the horizontal and vertical counters.
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;



reg a;
initial a = 0;
reg b;
initial b = 0;
reg c;
initial c = 0;
reg d;
initial d = 0;
reg e;
initial e = 0;
reg f;
initial f = 0;
reg g;
initial g = 0;
reg h;
initial h = 0;
reg i;
initial i = 0;
reg j;
initial j = 0;
reg k;
initial k = 0;
reg l;
initial l = 0;
reg m;
initial m = 0;
reg n;
initial n = 0;
reg o;
initial o = 0;
reg xx;
initial xx = 0;

//the always asterisk here is jusst a shortcut for writing all inputs (allegedly). also converts
//sequential into combinational but not sure if thats entirely relevant to keeping score changing.
always @ (*)
begin
case(current_score)
0:
begin
	a = 0;
	b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j = 0;
	k = 0;
	l = 0;
	m = 0;
	n = 0;
	o = 0;
	xx = 1;
end
1:
begin
    xx=0;
    b = 0;
	c = 0;
	d=0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j=0;
	a=1;
end
2: 
begin
    xx = 0;
	a = 0;
	c = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	d = 0;
	j=0;
	b = 1;

end
3: 
begin
    xx = 0;
    a=0;
    b = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j=0;
	c = 1;
end
4: 
begin
    xx = 0;
    a = 0;
	b = 0;
	c = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j=0;
	d = 1;
end
5:
begin
    xx = 0;
    a = 0;
	b = 0;
	c = 0;
	d = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j=0;
	e = 1;
end
6: 
begin
    xx = 0;
	a=0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	g = 0;
	h = 0;
	i = 0;
//	j=0;
	f = 1;
end
7:
begin
    xx = 0;
    a=0;
    b = 0;
	c = 0;
	d=0;
	e = 0;
	f = 0;
	h = 0;
	i = 0;
//	j=0;
	g = 1;
end
8:
begin
    xx = 0;
    a=0;
    b = 0;
	c = 0;
	d=0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j=0;
	h = 1;
end
9: 
begin
    xx = 0;
	a = 0;
	b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	j=0;
	i = 1;
end
10:
begin 
    xx = 1;
	a = 0;
	b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	j = 1;
end
11:
begin 
    xx = 0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	a = 1;
	j = 1;
	
end
12:
begin
    xx = 0;
    a=0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	b = 1;
	j = 1;
end
13:
begin
    xx = 0;
    a=0;
    b = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	c = 1;
	j=1;
end
14:
begin 
    xx = 0;
    a=0;
    b = 0;
	c = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	d = 1;
	j = 1;
end
15:
begin 
	xx = 0;
    a=0;
    b = 0;
	c = 0;
	d = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 0;
	e=1;
	j=1;
end
16:
begin
    xx = 0;
    a=0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	g = 0;
	h = 0;
	i = 0;
	f=1;
	j=1;
end
17:
begin
    xx = 0;
    a = 0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	h = 0;
	i = 0;
	g=1;
	j=1;
	
end
18:
begin
   xx = 0;
    a=0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	i = 0;
	h=1;
	j=1;
end
19:
begin
    xx = 0;
    a=0;
    b = 0;
	c = 0;
	d = 0;
	e = 0;
	f = 0;
	g = 0;
	h = 0;
	i = 1;
	j=1;
end

endcase
end
	



always @(*)
begin

	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
	       if (state == 0)  
        begin
//        red = 3'b000;
//        green = 3'b000;
//        blue = 2'b00;
//        if(( (((hc>(hbp+60))&&(hc<(hbp+100))) &&  ( (vc>(vbp+200) && vc<(vbp+210)) || (vc>(vbp+260)&& vc<(vbp+270)) ) )   || (((hc>(hbp+60))&&(hc<(hbp+70))) && (vc>(vbp+200)&& vc<(vbp+270))) || (((hc>(hbp+90))&&(hc<(hbp+100))) && (vc>(vbp+200)&& vc<(vbp+220)))  ) || ((vc>(vbp+230)&& vc<(vbp+240)) && (hc>(hbp+80)&& hc<(hbp+100))))
//              begin
//              red=3'b111;
//              green=3'b111;
//              blue=2'b11 ; 
//              end
//        else if (( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
//            begin
//              red=3'b111;
//              green=3'b111;
//              blue=2'b11 ;
//            end
//        else if (( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
//            begin
//              red=3'b111;
//              green=3'b111;
//              blue=2'b11 ;
//            end
    if ((hc > 600)|| (hc < 40) || (vc > 440) || (vc <40))
                begin
                red <= 3'b000;    
                green <= 3'b000;    
                blue <= 2'b00;    
                end
    
       else if (
         
           ( hc>=119+70 && hc<=210+70 && vc>=130 && vc<=150 ) ||
            ( hc>=119+70 && hc<=139+70 && vc>=130 && vc<=230 )||
           ( hc>=119+70 && hc<=210+70 && vc>=210 && vc<=230 )||
           ( hc>=190+70 && hc<=210+70 && vc>=160 && vc<=230 )||
            ( hc>=169+70 && hc<=210+70 && vc>=160 && vc<=180 )|| 
            
            ( hc>=219+70 && hc<=310+70 && vc>=130 && vc<=150 )||
            ( hc>=219+70 && hc<=239+70 && vc>=130 && vc<=230 )||
            ( hc>=290+70 && hc<=310+70 && vc>=130 && vc<=230 )||
           ( hc>=219+70 && hc<=310+70 && vc>=170 && vc<=190 )||
           
            ( hc>=319+70 && hc<=410+70 && vc>=130 && vc<=150 )||
            ( hc>=319+70 && hc<=339+70 && vc>=130 && vc<=230 )||
           ( hc>=354+70 && hc<=374+70 && vc>=130 && vc<=180 )||
           ( hc>=390+70 && hc<=410+70 && vc>=130 && vc<=230 )||
           
           ( hc>=419+70 && hc<=510+70 && vc>=130 && vc<=150 )||
           ( hc>=419+70 && hc<=439+70 && vc>=130 && vc<=230 )||
           ( hc>=419+70 && hc<=469+70 && vc>=170 && vc<=190 )||
           (hc>=419+70 && hc<=510+70 && vc>=210 && vc<=230 )||
           
            ( hc>=119+70 && hc<=210+70 && vc>=250 && vc<=270 )||
           ( hc>=119+70 && hc<=139+70 && vc>=250 && vc<=350 )||
            (hc>=119+70 && hc<=169+70 && vc>=290 && vc<=310 )||
           ( hc>=119+70 && hc<=210+70 && vc>=330 && vc<=350 )||
           
            ( hc>=219+70 && hc<=310+70 && vc>=250 && vc<=270 ) ||
           ( hc>=219+70 && hc<=239+70 && vc>=250 && vc<=350 ) ||
           ( hc>=290+70 && hc<=310+70 && vc>=250 && vc<=350 )||
           
           ( hc>=315+80 && hc<=410+80 && vc>=250 && vc<=270 ) ||
           ( hc>=319+80 && hc<=339+80 && vc>=250 && vc<=350 ) ||
           ( hc>=315+80 && hc<=410+80 && vc>=320 && vc<=350 )||
            ( hc>=390+80 && hc<=410+80 && vc>=250 && vc<=350 )          
            
       )
       begin 
        red <= 3'b111; //colour for game end.    
        green <= 3'b000;    
        blue <= 2'b11; 
       end
       
       else
        begin
            red <= 3'b000; 
            blue <= 2'b00; 
            green <= 3'b00; 
        end    
          
    end 
  else if (state == 2 || state==1)
  begin
	       /*if (e && ((((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+40)&& vc<(vbp+60))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+70)&& vc<(vbp+90))) ) )
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
	       else if (xx && ( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
        begin   
                red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
	   
	       else if (a && ((((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100))))  )
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
        
	       else if ( b && ((((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+70)&& vc<(vbp+90))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+40)&& vc<(vbp+60))) ) )
            begin
                red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
            end
        else if ( c && ((((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+70)&& vc<(vbp+90))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+40)&& vc<(vbp+60))) ) )
            begin
                red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
            end	   
	
       
        else if (d &&   ( (((hc>(hbp+590))&&(hc<(hbp+630))) && (vc>(vbp+60)&& vc<(vbp+70))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+40)&& vc<(vbp+60))) ) )
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
        else if (e && ((((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+40)&& vc<(vbp+60))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+70)&& vc<(vbp+90))) ) )
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;

        end
        else if (f && ( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+70)&& vc<(vbp+90)))  ))
        begin
              red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
        else if (g && ( (((hc>(hbp+590))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+40))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end        
        else if (h && ( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+100))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end        
        else if (i && ( (((hc>(hbp+590))&&(hc<(hbp+630))) &&  ( (vc>(vbp+30) && vc<(vbp+40))|| (vc>(vbp+60)&& vc<(vbp+70)) || (vc>(vbp+90)&& vc<(vbp+100)) ) )   || (((hc>(hbp+590))&&(hc<(hbp+600))) && (vc>(vbp+30)&& vc<(vbp+60))) || (((hc>(hbp+620))&&(hc<(hbp+630))) && (vc>(vbp+30)&& vc<(vbp+100)))  ))
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end
        else if (j && ((((hc>(hbp+570))&&(hc<(hbp+580))) && (vc>(vbp+30)&& vc<(vbp+100)))) )
        begin
               red = 3'b001;
				green = 3'b000;
				blue = 2'b11;
        end*/
           
        if (( (jumprate1 == 0 && jumprate2==0 && jumprate3==0)||(jumprate1 == 1 && jumprate2==1 && jumprate3==1)||
        (jumprate1 == 0 && jumprate2==0 && jumprate3==1)||
        (jumprate1 == 0 && jumprate2==1 && jumprate3==1) )&& ((((hc>(hbp+20))&&(hc<(hbp+30))) && (vc>(vbp+70)&& vc<(vbp+100)))))
        begin
            red = 3'b001;
            green = 3'b000;
            blue = 2'b11  ; 
        end   
        else if (( (jumprate1 == 0 && jumprate2==0 && jumprate3==1)||
        (jumprate1 == 0 && jumprate2==1 && jumprate3==1) )&& ((((hc>(hbp+35))&&(hc<(hbp+45))) && (vc>(vbp+60)&& vc<(vbp+100)))) )
        begin
            red = 3'b001;
            green = 3'b000;
            blue = 2'b11  ;
        end
        else if ((jumprate1 == 0 && jumprate2==1 && jumprate3==1) && ((((hc>(hbp+50))&&(hc<(hbp+60))) && (vc>(vbp+50)&& vc<(vbp+100)))))                 
        begin
             red = 3'b001;
            green = 3'b000;
            blue = 2'b11  ;
        end
        
                   
		// now display different colors every 80 pixels
		// while we're within the active horizontal range
		// -----------------
		
        
		else 	if(hc > (hbp+50) && hc < (hbp+55) && d && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+60) && hc < (hbp+65) && e && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+70) && hc < (hbp+75) && f && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+80) && hc < (hbp+85) && g && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+90) && hc < (hbp+95) && h && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+100) && hc < (hbp+105) && i && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+110) && hc < (hbp+115) && j && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+120) && hc < (hbp+125) && k && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+130) && hc < (hbp+135) && l && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+140) && hc < (hbp+145) && m && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+150) && hc < (hbp+155) && n && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else 	if(hc > (hbp+160) && hc < (hbp+165) && o && vc >= 504 && vc <= 514)
				begin
					red = 3'b111;
					green = 3'b111;
					blue = 2'b11;
				end
		else if(vc > (480-bird_coord)-20 && vc < (480-bird_coord)+20 && hc > hbp+100 && hc < hbp+140) //bird col
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end

		//pipes and their colours
		
		else if ((hc < hfp-pipe_pos+50 && hc > hfp-pipe_pos) && (vc < pipe_array1+75 || vc > pipe_array1+215 && vc < 500))
		begin //next pipe
			red = 3'b000;
			green = 3'b000;
			blue = 2'b11;
		end		
		else if ((hc < hfp-345-pipe_pos+50 && hc > hfp-345-pipe_pos) && (vc < pipe_array0+75 || vc > pipe_array0+215 && vc < 500))
		begin //first pipe, for some reasno changing this colour causes shit to flash for some reason.
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end		
		//grass 
		else if (vc >= 500)
		begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b00;
		end
		// top border
		else if (vc <= 40)
		begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b10;
		end
		// colour of the backgroungd
		else if (hc >= (hbp) && hc < (hbp+640))
		begin

			red = 3'b000;
			green = 3'b010;
			blue = 2'b01;
			if (current_score==15 )
			begin
			    red = 3'b101;
                green = 3'b110;
			    blue = 2'b10; 
			end 
		
		end
		  
	
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	else if(state==3) //start screen
	   begin
    
       if (
         
                ( hc>=200 && hc<=300 && vc>= 300 && vc<=320 ) ||
              ( hc>=200 && hc<=300 && vc>= 340 && vc<=360 ) ||
              ( hc>=200 && hc<=300 && vc>= 380 && vc<=400 ) ||
              ( hc>=200 && hc<=220 && vc>= 320 && vc<=340 ) ||
              ( hc>=280 && hc<=300 && vc>= 360 && vc<=380 ) ||
              
              ( hc>=310 && hc<=410 && vc>=300 && vc<=320 ) ||
              ( hc>=350 && hc<=370 && vc>=320 && vc<=400 ) ||

              ( hc>=420 && hc<=520 && vc>=300 && vc<=320 ) ||
              ( hc>=420 && hc<=440 && vc>=320 && vc<=400 ) ||
              ( hc>=500 && hc<=520 && vc>=320 && vc<=400 ) ||
              ( hc>=440 && hc<=500 && vc>=340 && vc<=360 ) ||
              
              ( hc>=530 && hc<=600 && vc>=300 && vc<=320 ) ||
              ( hc>=530 && hc<=550 && vc>=320 && vc<=400 ) ||
              ( hc>=530 && hc<=630 && vc>=340 && vc<=360 ) ||
              ( hc>=620 && hc<=630 && vc>=360 && vc<=400 ) ||
              ( hc>=590 && hc<=600 && vc>=300 && vc<=340 ) || 
              
                ( hc>=640 && hc<=740 && vc>=300 && vc<=320 ) ||
              ( hc>=680 && hc<=700 && vc>=320 && vc<=400 )      
            
       )
       begin 
        red <= 3'b111; //start screen   
        green <= 3'b000;    
        blue <= 2'b00; 
       end
       
       else
        begin
            red <= 3'b000; 
            blue <= 2'b00; 
            green <= 3'b00; 
        end    
          
	       
	       
	       
	       
	       
	       
	   end
	end
	

	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule
