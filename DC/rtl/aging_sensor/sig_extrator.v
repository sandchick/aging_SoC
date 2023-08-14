module sig_extrator #(
    parameter time_count = 8
) (
    input [time_count - 1 :0] counter,
    output wire [time_count - 1 :0] aging_signal
);

    assign aging_signal = counter;

    
endmodule