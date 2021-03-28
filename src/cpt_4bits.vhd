library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE . NUMERIC_STD.ALL ;

entity cpt_4bits is
    Port ( clk, rst, CE                 :   in  STD_LOGIC;
           cpt_en, cpt_init             :   in  STD_LOGIC;
           
           val_btn                      :   in  STD_LOGIC_VECTOR (1 downto 0);
           
           addr_max                     :   out STD_LOGIC;
           ind_i, ind_j                 :   out STD_LOGIC_VECTOR (1 downto 0);             
           pr_addr, curr_addr, nx_addr  :   out STD_LOGIC_VECTOR (3 downto 0));
end cpt_4bits;

architecture beh_cpt_4bits of cpt_4bits is

    signal i, j                         : unsigned (1 downto 0); 
    signal pr_cpt, curr_cpt, nx_cpt     : unsigned (3 downto 0);
 
    begin
    
    cptsync : process (clk , rst)
        
        begin
        
            if ( rst = '1') then
                i           <= "00";
                j           <= "00";

                curr_cpt    <= "0000";
                nx_cpt      <= "0000";
                
                addr_max    <= '0';
            
            elsif ( clk = '1' and clk ' event ) then
            
                if (CE = '1') then
                
                    if (cpt_init = '1') then
                        case val_btn IS
                            when "00" => i <= "00"; j <= "00";
                            when "01" => i <= "11"; j <= "00";
                            when "10" => i <= "00"; j <= "11";
                            when "11" => i <= "00"; j <= "00";
                            when others =>
                        end case;
                        
                    elsif (cpt_en = '1') then
                    
                        case val_btn IS
                            when "00" => -- incrémentation j, incrémentation i
                                j <= j + 1;
                                
                                if(j = "11") then 
                                    i <= i + 1;
                                end if;
                                
                                if(curr_cpt = 15) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;     
                                                                                     
                            when "01" => -- décrémentation i, incrémentation j
                                i <= i - 1;
                                
                                if(i = "00") then
                                    i <= "11"; 
                                    j <= j + 1;
                                end if;
                                
                                if(curr_cpt = 12) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;     
    
                            when "10" => -- décrémentation j, incrémentation i
                                j <= j - 1;
                                
                                if(j = "00") then
                                    j <= "11"; 
                                    i <= i + 1;
                                end if;  
                                
                                if(curr_cpt = 3) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;                          

                            when "11" => -- incrémentation i, incrémentation j
                                i <= i + 1;
                                
                                if(i = "11") then 
                                    j <= j + 1;
                                end if;
                                
                                if(curr_cpt = 3) then
                                    addr_max <= '1';
                                else
                                    addr_max <= '0';
                                end if;  

                            when others => -- do nothing  
                        end case;
                               
                        end if;
                        
                curr_cpt <= pr_cpt;
                nx_cpt <= curr_cpt;             
                
            end if;
        end if; 
                                  
    end process cptsync;
   
    pr_cpt    <= resize(resize(j,4)*4, 4)+resize(i, 4);
    
    pr_addr     <= std_logic_vector(pr_cpt);
    curr_addr   <= std_logic_vector(curr_cpt);
    nx_addr     <= std_logic_vector(nx_cpt);
    
    ind_i       <= std_logic_vector(i(1 DOWNTO 0));
    ind_j       <= std_logic_vector(j(1 DOWNTO 0));
    
end beh_cpt_4bits;