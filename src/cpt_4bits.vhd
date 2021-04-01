library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE . NUMERIC_STD.ALL ;

entity cpt_4bits is
    Port ( clk, rst, CE                 :   in  std_logic;
           cpt_en, cpt_init             :   in  std_logic;
           
           val_btn                      :   in  std_logic_vector (3 downto 0);
           val_btn_init                 :   in  std_logic;
           rst_b                        :   in  std_logic;
           
           addr_max                     :   out std_logic;          
           pr_addr, curr_addr, nx_addr  :   out std_logic_vector (3 downto 0));
end cpt_4bits;

architecture beh_cpt_4bits of cpt_4bits is

    signal i, j                         : unsigned (1 downto 0); 
    signal u, v                         : unsigned (1 downto 0); 
    signal pr_cpt, curr_cpt, nx_cpt     : unsigned (3 downto 0);
    signal val_btn_b                    : std_logic_vector(3 downto 0):= "1000";
 
    begin
    
    
    cptsync : process (clk , rst)
        
        begin
        
            if ( rst = '0') then
                i           <= "00";
                j           <= "00";
                
                u           <= "00";
                v           <= "00";

                pr_cpt      <= "0000";
                
                addr_max    <= '0';
            
            elsif ( clk = '1' and clk ' event ) then
            
                if (CE = '1') then
                               
                    if (cpt_init = '1') then
                        case val_btn_b IS
                            when "0001" => i <= "00"; j <= "00"; u <= "00"; v <= "01";
                            when "0010" => i <= "11"; j <= "00"; u <= "10"; v <= "00";
                            when "0100" => i <= "00"; j <= "11"; u <= "00"; v <= "10";
                            when "1000" => i <= "00"; j <= "00"; u <= "01"; v <= "00";
                            when others =>
                        end case;
                        
                    elsif (cpt_en = '1') then
                    
                        case val_btn_b IS
                            when "0001" => -- incrémentation j, incrémentation i
                                j <= j + 1; 
                                v <= v + 1;
                                
                                if(j = "11") then 
                                    i <= i + 1;
                                end if;
                                
                                if(v = "11") then 
                                    u <= u + 1;
                                end if;
                                
                                if(nx_cpt = 15) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;     
                                                                                     
                            when "0010" => -- décrémentation i, incrémentation j
                                i <= i - 1;
                                u <= u - 1;
                                
                                if(i = "00") then
                                    i <= "11"; 
                                    j <= j + 1;
                                end if;
                                
                                if(u = "00") then
                                    u <= "11"; 
                                    v <= v + 1;
                                end if;
                                
                                if(nx_cpt = 12) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;     
    
                            when "0100" => -- décrémentation j, incrémentation i
                                j <= j - 1;
                                v <= v - 1;
                                
                                if(j = "00") then
                                    j <= "11"; 
                                    i <= i + 1;
                                end if;  
                                
                                if(v = "00") then
                                    v <= "11"; 
                                    u <= u + 1;
                                end if;
                                
                                if(nx_cpt = 3) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;                          

                            when "1000" => -- incrémentation i, incrémentation j
                                i <= i + 1;
                                u <= u + 1;
                                
                                if(i = "11") then 
                                    j <= j + 1;
                                end if;
                                
                                if(u = "11") then 
                                    v <= v + 1;
                                end if;
                                
                                if(nx_cpt = 15) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;  

                            when others => -- do nothing  
                        end case;
                               
                        end if;
                        
                        pr_cpt <= curr_cpt;          
            end if;
        end if; 
                                  
    end process cptsync;

    process(rst_b, val_btn, val_btn_init)
    begin
    
        if(val_btn_init = '1') then
             val_btn_b <= "1000";
        
        else
            
            if(rst_b = '1') then  
                val_btn_b <= "0000";
            else
                if(val_btn(0) = '1') then
                    val_btn_b(0) <= val_btn(0);
                elsif(val_btn(1) = '1') then
                    val_btn_b(1) <= val_btn(1);
                elsif(val_btn(2) = '1') then
                    val_btn_b(2) <= val_btn(2);
                elsif(val_btn(3) = '1') then
                    val_btn_b(3) <= val_btn(3);
                    end if;
        
        end if;    
    end if;
    
    end process;

    nx_cpt    <= resize(resize(v,4)*4, 4)+resize(u, 4);
    curr_cpt  <= resize(resize(j,4)*4, 4)+resize(i, 4);
    
    pr_addr     <= std_logic_vector(pr_cpt);
    curr_addr   <= std_logic_vector(curr_cpt);
    nx_addr     <= std_logic_vector(nx_cpt);
    
end beh_cpt_4bits;
