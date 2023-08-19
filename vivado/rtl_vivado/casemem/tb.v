module tb (
);
reg [7:0] mem [2**19:0];
initial
begin
    $readmemh ("./case.pat", mem);
    $display (mem[0]);   
    $finish;
end
endmodule