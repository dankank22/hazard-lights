module simple (clk, reset, sw1, sw0, out);
input logic clk, reset, sw0, sw1;
output logic [3:0]out;
// all states
enum { calm101, LtR001, RtL100, mid010 } ps, ns;
// ns logic
always_comb begin
case (ps)
    calm101: begin
	 out = 3'b101;
            if (!sw1 && !sw0 )     //SW[1] = 0 && SW[0] = 0 
                ns = mid010;
            else if (!sw1 && sw0)  //SW[1] = 0 && SW[0] = 1 
                ns = mid010;
            else                   //SW[1] = 1 && SW[0] = 0 
                ns = mid010;
        end
    LtR001: begin
	 out = 3'b001;
            if (!sw1 && !sw0)      //SW[1] = 0 && SW[0] = 0 
                ns = calm101;
            else if (!sw1 && sw0)  //SW[1] = 0 && SW[0] = 1 
                ns = mid010;
            else                   //SW[1] = 1 && SW[0] = 0 
                ns = RtL100;
        end
    RtL100: begin
	 out = 3'b100;
            if (!sw1 && !sw0)      //SW[1] = 0 && SW[0] = 0 
                ns = calm101;
            else if (!sw1 && sw0)  //SW[1] = 0 && SW[0] = 1 
                ns = LtR001;
            else                   //SW[1] = 1 && SW[0] = 0 
                ns = mid010;           
        end
	 mid010: begin
	 out = 3'b010;
            if (!sw1 && !sw0)      //SW[1] = 0 && SW[0] = 0 
                ns = calm101;
            else if (!sw1 && sw0)  //SW[1] = 0 && SW[0] = 1 
                ns = RtL100;
            else                   //SW[1] = 1 && SW[0] = 0 
                ns = LtR001;
        end
endcase
end

//when reset, goes to calm state
always_ff @(posedge clk) begin
if (reset)
ps <= calm101;
else
ps <= ns;
end
endmodule

