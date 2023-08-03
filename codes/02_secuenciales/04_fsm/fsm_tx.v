module fsm_tx (
  input                 clk_i,  //Reloj de tarjeta
  input                 rst_i,  //Reset del sistema
  input                 st_i,   //Start
  input                 psel_i, //Selector de paridad
  input                 z_i,    //Base de tiempo
  output reg    [3:0]   en_o,   //Habilitador de mux
  output reg            eot_o   //Fin de transmision
);  

  reg [3:0] present_state, next_state;
    
  //Combinational next state logic and output
  always @(present_state, st_i, psel_i, z_i) begin
    next_state = present_state;
        case (present_state)
            0 : begin                       //Espera por start transmission
                    en_o = 0; eot_o = 1;
                if(st_i)
                    next_state = 1;
                end
            
            1 : begin                       //Sincronizacion con clk_div                    
                    en_o = 0; eot_o = 0;
                    if (z_i)
                       next_state = 2;
                end
        
            2 : begin                       //Sincronizacion con clk_div y envio de stop bit
                    en_o = 1; eot_o = 0;
                    if(z_i)
                       next_state = 3;
                end
            
            3 : begin                       //Sincronizacion con clk_div y envio de start bit
                    en_o  = 2; eot_o = 0;
                    if(z_i)
                       next_state = 4;
                end
            
            4 : begin                       //Sincronizacion con clk_div y envio de LSB de d_i (d_i[0])
                    en_o = 3; eot_o = 0;
                    if(z_i)
                       next_state = 5;
                end
            
            5 : begin                       //Sincronizacion con clk_div y envio d_i[1]
                    en_o = 4; eot_o = 0;
                    if(z_i)
                       next_state = 6;
                end
            
            6 : begin                       //Sincronizacion con clk_div y envio d_i[2]
                    en_o = 5; eot_o = 0;
                    if(z_i)
                       next_state = 7;
                end
                
            7 : begin                       //Sincronizacion con clk_div y envio d_i[3]
                    en_o = 6; eot_o = 0;
                    if(z_i)
                       next_state = 8;
                end
            
            8 : begin                       //Sincronizacion con clk_div y envio d_i[4]
                    en_o = 7; eot_o = 0;
                    if(z_i)
                       next_state = 9;
                end
            
            9 : begin                       //Sincronizacion con clk_div y envio d_i[5]
                    en_o = 8; eot_o = 0;
                    if(z_i)
                       next_state = 10;
                end
            
           10 : begin                       //Sincronizacion con clk_div y envio d_i[6]
                    en_o = 9; eot_o = 0;
                    if(z_i) begin
                       if(psel_i)
                          next_state = 11;
                       else
                          next_state = 0;
                    end
                end
            
           11 : begin                       //Sincronizacion con clk_div y envio de MSB de d_i (d_i[7])
                    en_o = 10; eot_o = 0;
                    if(z_i)
                       next_state = 0;
                    end
            
            default :  begin                //Envio de stop bit por default
                           en_o = 0; eot_o = 0;
                           next_state = 0;
                       end              
        endcase 
    end     
        
    // Sequential logic
    always @(posedge clk_i, posedge rst_i) begin
        if (rst_i)
            present_state <= 0;
        else
            present_state <= next_state;
    end     
    
endmodule