//split .pat file into 4 files
`timescale 1ns/100ps

module top();

parameter DATAWIDTH=8;
parameter ADDRWIDTH=17;	//byte addrress width
parameter MEMDEPT = 2**(ADDRWIDTH-2);	//divided by 4---- 32768

integer fid0,fid1,fid2,fid3;
reg[31:0] i;
reg[31:0] mem_temp [(MEMDEPT-1):0];	

initial 
begin 
	$readmemh("D:/PHM/code/aging_SoC/vivado/sim/case.pat",mem_temp);	
end

initial begin
	fid0 = $fopen("case0.pat");
	fid1 = $fopen("case1.pat");
	fid2 = $fopen("case2.pat");
	fid3 = $fopen("case3.pat");

	for(i=0;i<MEMDEPT;i=i+1) begin
		if((^mem_temp[i][31:24]) === 1'bx ) 
			$fdisplay(fid3,"@%h %h",i,8'h00);
		else 
			$fdisplay(fid3,"@%h %h",i,mem_temp[i][31:24]);
		if((^mem_temp[i][23:16]) === 1'bx ) 
			$fdisplay(fid2,"@%h %h",i,8'h00);
		else 
			$fdisplay(fid2,"@%h %h",i,mem_temp[i][23:16]);
		if((^mem_temp[i][15:8]) === 1'bx ) 
			$fdisplay(fid1,"@%h %h",i,8'h00);
		else 
			$fdisplay(fid1,"@%h %h",i,mem_temp[i][15:8]);
		if((^mem_temp[i][7:0]) === 1'bx ) 
			$fdisplay(fid0,"@%h %h",i,8'h00);
		else 
			$fdisplay(fid0,"@%h %h",i,mem_temp[i][7:0]);
	end
	
	$fclose("case0.pat");	
	$fclose("case1.pat");	
	$fclose("case2.pat");		
	$fclose("case3.pat");	
end

endmodule
