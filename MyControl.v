`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:49 07/31/2019 
// Design Name: 
// Module Name:    MyControl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MyControl(op,RegDst,Jump,Branch,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,PCToReg,ExtMode);
	input [5:0] op;                                  
	output reg [1:0] RegDst;
	output reg Jump,Branch,MemtoReg;                 
	output reg [3:0] ALUOp;                          
	output reg MemWrite,ALUSrc,RegWrite,PCToReg;
	output reg ExtMode;

	always@(op) begin 
		if(op==6'b000000)begin   // R_TYPE
			ALUOp<=4'b0010; 
			RegDst<=2'b01; //write할 주소가 rd이니까
			ALUSrc<=1'b0; // immi값이 아닌 rt값을 불러와야 하니까     
			RegWrite<=1'b1; //regster에 쓰여져야 하니까(RD)
			MemtoReg<=1'b0;   
			MemWrite<=1'b0; //MEM과 관계 없으니   
			Jump<=1'b0; //
			Branch<=1'b0;      
			PCToReg<=1'b0;
			ExtMode<=1'b0; //Don't care 
		end 
		else if(op==6'b001000) begin // addi
			ALUOp<=4'b0000;   
			RegDst<=2'b00; //use reg write -> rt  
			ALUSrc<=1'b1;     
			RegWrite<=1'b1; //write in reg
			MemtoReg<=1'b0; //no use mem write -> don't care reg destination
			MemWrite<=1'b0; //no write in mem  
			Jump<=1'b0;       
			Branch<=1'b0;     
			PCToReg<=1'b0;
			ExtMode<=1'b0; //zero extended
		end 
		else if(op==6'b000101) begin // Bne
			ALUOp<=4'b0001;   
			RegDst<=2'bxx; //no use reg write -> don't care reg destination     
			ALUSrc<=1'b0;     
			RegWrite<=1'b0; //no write in reg
			MemtoReg<=1'bx; //no use mem write -> don't care reg destination
			MemWrite<=1'b0; //no write in mem  
			Jump<=1'b0;       
			Branch<=1'b1;     
			PCToReg<=1'b0;
			ExtMode<=1'b1;
		end 
		else if(op==6'b101001) begin // slti
			ALUOp<=4'b0100;
			RegDst<=2'b00; //write할 주소가 rt이니까
			ALUSrc<=1'b1; //rt값이 아닌 immi값을 연산에 target으로 사용
			RegWrite<=1'b1; //regster에 쓰여져야 하니까(Rt)
			MemtoReg<=1'b0; //mem 접근 x
			MemWrite<=1'b0;
			Jump<=1'b0;  
			Branch<=1'b0;
			PCToReg<=1'b0;
			ExtMode<=1'bx; 
		end
		else if(op==6'b001110) begin // xori
			ALUOp<=4'b0011;
			RegDst<=2'b00; //i type => destination : rt 
         ALUSrc<=1'b1;  //imm
         RegWrite<=1'b1; //write result in reg
         MemtoReg<=1'b0; 
         MemWrite<=1'b0;
         Jump<=1'b0;   
         Branch<=1'b0; 
 			PCToReg<=1'b0;
			ExtMode<=1'b0; 
      end
		else if(op==6'b001010) begin // slti
			ALUOp<=4'b0100;
			RegDst<=2'b00; //i type => destination : rt 
         ALUSrc<=1'b1;  //imm
         RegWrite<=1'b1;
         MemtoReg<=1'b0;
         MemWrite<=1'b0;
         Jump<=1'b0;   
         Branch<=1'b0; 
 			PCToReg<=1'b0;
			ExtMode<=1'b0; 
      end
		else if(op==6'b000011) begin // jal
			ALUOp<=4'b1101;
			RegDst<=2'b10; //31
         ALUSrc<=1'b0;  
         RegWrite<=1'b1;
         MemtoReg<=1'bx;
         MemWrite<=1'b0;
         Jump<=1'b1;   
         Branch<=1'b0; 
 			PCToReg<=1'b1;
			ExtMode<=1'b1; 
      end
		else begin
			ALUOp<=4'bx;   
			RegDst<=2'bxx; 
			ALUSrc<=1'bx;  
			RegWrite<=1'bx;
			MemtoReg<=1'bx;
			MemWrite<=1'bx;
			Jump<=1'bx;    
			Branch<=1'bx;  
			PCToReg<=1'bx;
			ExtMode<=1'bx; 
		end
	end
endmodule
/*
		else if(op==6'b000000) begin // SLL
			ALUOp<=4'b0010; //sll 
			RegDst<=2'b01; //write할 주소가 rd이니까
			ALUSrc<=1'b0; // immi값이 아닌 rt값을 불러와야 하니까     
			RegWrite<=1'b1; //regster에 쓰여져야 하니까(RD)
			MemtoReg<=1'b0;   
			MemWrite<=1'b0; //MEM과 관계 없으니   
			Jump<=1'b0; //
			Branch<=1'b0;     
			PCToReg<=1'b0;
			ExtMode<=1'bx; 
		end*//*
		//bne => branch && zero = 0 mux always chose pc+4
		else if(op==6'b000000) begin // SRA Shift right arithmetic
			ALUOp<=4'b0010; //sra 
			RegDst<=2'b01; //write할 주소가 rd이니까
			ALUSrc<=1'b0; // immi값이 아닌 rt값을 불러와야 하니까     
			RegWrite<=1'b1; //regster에 쓰여져야 하니까(RD)
			MemtoReg<=1'b0;   
			MemWrite<=1'b0; //MEM과 관계 없으니   
			Jump<=1'b0; //
			Branch<=1'b0;     
			PCToReg<=1'b0;
			ExtMode<=1'bx;
		end *//*
		else if(op==6'b000000) begin // multu
			ALUOp<=4'b0010; //function
			RegDst<=2'b01; //write할 주소가 rd이니까
			ALUSrc<=1'b0; // immi값이 아닌 rt값을 불러와야 하니까     
			RegWrite<=1'b1; //regster에 쓰여져야 하니까(RD)
			MemtoReg<=1'b0;   
			MemWrite<=1'b0; //MEM과 관계 없으니   
			Jump<=1'b0; //
			Branch<=1'b0;     
			PCToReg<=1'b0;
			ExtMode<=1'bx; 
		end*/
/*		else if(op==6'b000000) begin // jalr
			ALUOp<=4'b1100; //default -> unsigned addition rs rt(=0) -> rs
			RegDst<=2'b01; //jalr => store pc to register(rd)
         ALUSrc<=1'b1;  //immi x rt o
         RegWrite<=1'b1; 
         MemtoReg<=1'b0; //mem x
         MemWrite<=1'b0;
         Jump<=1'b1;    
         Branch<=1'b0; 
			PCToReg<=1'bx;
			ExtMode<=1'b1; 
      end*/