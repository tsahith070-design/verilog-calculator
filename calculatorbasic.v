`timescale 1ns / 1ps


module calculatorbasic(input [7:0]A,input [7:0]B,input [2:0]OPERATION,input eqlto,input reset,output reg [15:0]RESULT,output reg sign_flag,output reg div_by_zero_flag
  );
    parameter ADD=3'b000,SUB=3'b001,MUL=3'b010,DIV=3'b011,AND=3'b100,OR=3'b101,XOR=3'b110,RSHIFT=3'b111;
    reg [15:0]ALU_result;
    reg signflag,divbyzero;
   
   
    always@(*)
    begin
     signflag=0;
     divbyzero=0;
     
      case(OPERATION)
        ADD: ALU_result = A + B;                              
        SUB: begin 
                    ALU_result = A - B; 
                    signflag=A<B;
                end                             
        MUL: ALU_result = A * B;                              
        DIV:begin 
                    ALU_result = (B==0)?0:A / B; 
                    divbyzero=(B==0);
                end
        AND: ALU_result = A & B;                             
        OR: ALU_result = A | B;                              
        XOR: ALU_result = A ^ B;                              
        RSHIFT: ALU_result = A >> B[2:0];
        default: ALU_result = 16'b0;
       
       endcase
     end     
     
     always@(posedge reset or posedge eqlto)
     begin
       if(reset)
         begin
           RESULT<=0;
           sign_flag<=0;
           div_by_zero_flag<=0;
         end
       else if(eqlto)
         begin
           RESULT<=ALU_result;
           sign_flag<=signflag;
           div_by_zero_flag<=divbyzero;
         end 
     end
endmodule
