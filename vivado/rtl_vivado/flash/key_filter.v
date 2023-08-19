module key_filter # (parameter TIME_20MS = 1_000_000)(
    input 			            clk		,
    input 			            rst_n	,
    input 			            key_in	,
    output 	             wire   	key_out	
);
    // 参数定义
    localparam IDLE  = 4'b0001;     //初始状态 
    localparam DOWN  = 4'b0010;     //按键按下抖动
    localparam HOLD  = 4'b0100;     //按键按下后稳定
    localparam UP    = 4'b1000;     //按键上升抖动
    // 信号定义
    reg     [3:0]           state_c         ;   //现态
    reg     [3:0]           state_n         ;   //次态

    // 状态转移条件定义
    wire                    idle2down       ;
    wire                    down2idle       ;
    wire                    down2hold       ;
    wire                    hold2up         ;
    wire                    up2idle         ;

    reg       key_r0          ;   //同步
    reg       key_r1          ;   //打拍
    wire      nedge           ;   //下降沿
    wire      pedge           ;   //上升沿

    // 20ms计数器
    reg     [19:0]          cnt_20ms        ;
    wire                    add_cnt_20ms    ;
    wire                    end_cnt_20ms    ;

    reg  key_out_r;    // 输出寄存

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            state_c <= IDLE;
        end
        else begin
            state_c <= state_n;
        end
    end


    assign idle2down = (state_c == IDLE) && nedge;                      // 检测到下降沿
    assign down2idle = (state_c == DOWN) && (pedge && ~end_cnt_20ms);   // 计时未到20ms时且出现上升沿表示按键意外抖动，回到初始态
    assign down2hold = (state_c == DOWN) && (~pedge && end_cnt_20ms);   // 计时到20ms时没有出现上升沿标志按键按下后保持稳定
    assign hold2up   = (state_c == HOLD) && (pedge);                    // 检测到上升沿跳转到上升态
    assign up2idle   = (state_c == UP)   && end_cnt_20ms;               // 计数器计数到20ms跳转到初始态

    always@(*)begin
        case(state_c)
            IDLE: begin
                if(idle2down)begin
                    state_n = DOWN;
                end
                else begin
                    state_n = state_c;
                end
            end
            DOWN: begin
                if(down2idle)begin
                    state_n = IDLE;
                end
                else if(down2hold)begin
                    state_n = HOLD;
                end
                else begin
                    state_n = state_c;
                end
            end
            HOLD: begin
                if(hold2up)begin
                    state_n = UP;
                end
                else begin
                    state_n = state_c;
                end
            end
            UP: begin
                if(up2idle)begin
                    state_n = IDLE;
                end
                else begin
                    state_n = state_c;
                end
            end
            default:state_n = state_c;
        endcase
    end


    // 20ms计数器
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_20ms <= 0;
        end
        else if(add_cnt_20ms)begin
            if(pedge || end_cnt_20ms)begin
                cnt_20ms <= 0;
            end
            else begin
                cnt_20ms <= cnt_20ms + 1'b1;
            end
        end
    end
    assign add_cnt_20ms = state_c == DOWN || state_c == UP;             // 当按键按下或上弹时开始计数
    assign end_cnt_20ms = add_cnt_20ms && (cnt_20ms == TIME_20MS - 1);  // 当计数到最大值或检测到上升沿计数器清零


    // 同步打拍
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            key_r0 <= 1'b1;
            key_r1 <= 1'b1;
        end
        else begin
            key_r0 <= key_in;
            key_r1 <= key_r0;
        end
    end

    assign nedge = ~key_r0 &  key_r1;   // 检测下降沿
    assign pedge =  key_r0 & ~key_r1;   // 检测上升沿


    // 按键赋值
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            key_out_r <= 1'b0;
        end
        else if(hold2up) begin
            key_out_r <= ~key_r1;
        end
        else begin
            key_out_r <= 1'b0;
        end
    end

    assign key_out = key_out_r;

endmodule

