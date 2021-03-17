----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2021 16:27:12
-- Design Name: 
-- Module Name: adresseur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity adresseur is
    Port (  clk, rst     : in STD_LOGIC;
            init         : in STD_LOGIC;
            index        : in STD_LOGIC_VECTOR (3 downto 0);
            addr_ram     : in STD_LOGIC_VECTOR (10 downto 0);
           
            addr_screen : out STD_LOGIC_VECTOR (16 downto 0)); --Nombre de pixel de l'écran : 320*240
           

end adresseur;

architecture Behavioral of adresseur is
    constant nb_px_ligne            : integer := 320;
    constant nb_px_cote             : integer := 40;
    
    signal addr                     : STD_LOGIC_VECTOR(13 downto 0); 
    signal cpt_ligne, cpt_colonne   : integer range 0 to nb_px_cote := 0;

    
    
    signal idx_tab                  : integer range 0 to 15 := 0;
    
    signal addr_ram_old : STD_LOGIC_VECTOR (10 downto 0) := addr_ram;

    type tab is array (0 to 15) of integer;
    signal addr_origine_grille : tab := (12879,12919,12959,12999,25679,25719,25759,25799,38479,38519,38559,38599,51279,51319,51359,51399);    
    --signal addr_origine_grille : tab := (X"667", X"67B", X"68F", X"6A3", X"12E7", X"12FB", X"130F", X"1F67", X"1F7B", X"1F8F", X"1FA3", X"2BE7", X"2C0F", X"2C23");

    
begin
    
    process(clk, rst)
    begin
        if ( rst = '0') then
            cpt_colonne <= 0;
            cpt_ligne <= 0;
            addr_ram_old <= addr_ram;
        elsif ( clk = '1' and clk ' event ) then
            if init = '1' then
                cpt_colonne <= 0;
                cpt_ligne <= 0;
                addr_ram_old <= addr_ram;
            elsif ( addr_ram_old /= addr_ram) then
                
                if cpt_colonne > (nb_px_cote-2) then --addr max - 1
                    cpt_colonne <= 0;
                    if cpt_ligne > (nb_px_cote-2) then
                        cpt_ligne <= 0;
                    else cpt_ligne <= cpt_ligne +1; end if;
                        
                else cpt_colonne <= cpt_colonne + 1; end if;


            end if;
            addr_ram_old <= addr_ram;
        end if;
    end process;
    
    
   idx_tab <=   1 when index = "0001" else
                2 when index = "0010" else
                3 when index = "0011" else
                4 when index = "0100" else
                5 when index = "0101" else
                6 when index = "0110" else
                7 when index = "0111" else
                8 when index = "1000" else
                9 when index = "1001" else
                10 when index = "1010" else
                11 when index = "1011" else
                12 when index = "1100" else
                13 when index = "1101" else
                14 when index = "1110" else
                15 when index = "1111" else
                0;
                
   addr_screen <=   std_logic_vector(to_unsigned((addr_origine_grille(idx_tab) + cpt_colonne + (cpt_ligne* nb_px_ligne)), 17)) ;
    
    
end Behavioral;
