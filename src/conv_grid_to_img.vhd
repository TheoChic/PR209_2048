----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2021 13:51:39
-- Design Name: 
-- Module Name: conv_grid_to_img - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_grid_to_img is
    Port ( clk, rst, CE : in STD_LOGIC;
           index_in     : in STD_LOGIC_VECTOR (3 downto 0);
           value_in     : in STD_LOGIC_VECTOR (11 downto 0);
           
           enable_mem, enable_cpt   :   in STD_LOGIC;
           init_cpt_addr_ram : in STD_LOGIC;    
           init_adresseur : in STD_LOGIC;  
                
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           addr_out : out STD_LOGIC_VECTOR (16 downto 0));
end conv_grid_to_img;

architecture Behavioral of conv_grid_to_img is

component RAMs_graphique is
    port (  clk     :   in STD_LOGIC;
            rst     :   in STD_LOGIC;
            CE      :   in STD_LOGIC;
            
            enable_mem  :   in STD_LOGIC;
            enable_cpt  :   in STD_LOGIC;
            cpt_init    :   in STD_LOGIC;
            
            adr_out :   out STD_LOGIC_VECTOR (10 downto 0);
            RAM_0   :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_2   :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_4   :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_8   :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_16  :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_32  :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_64  :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_128 :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_256 :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_512 :   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_1024:   out STD_LOGIC_VECTOR (7 downto 0);
            RAM_2048:   out STD_LOGIC_VECTOR (7 downto 0)
            );
end component;

component MUX_ram_conv_image is
    Port ( SEL          :   in      STD_LOGIC_VECTOR (11 downto 0);
           data_in_0    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_2    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_4    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_8    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_16   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_32   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_64   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_128  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_256  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_512  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_1024 :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_2048 :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_out     :   out     STD_LOGIC_VECTOR (7 downto 0)
           );
end component;

component adresseur is
    Port (  clk, rst     : in STD_LOGIC;
            init         : in STD_LOGIC;
            index        : in STD_LOGIC_VECTOR (3 downto 0);
            addr_ram     : in STD_LOGIC_VECTOR (10 downto 0);
           
            addr_screen : out STD_LOGIC_VECTOR (16 downto 0)); --Nombre de pixel de l'écran : 160*100
end component;   

signal sig_RAM_0, sig_RAM_2, sig_RAM_4, sig_RAM_8, sig_RAM_16, sig_RAM_32, sig_RAM_64, sig_RAM_128, sig_RAM_256, sig_RAM_512, sig_RAM_1024, sig_RAM_2048 : STD_LOGIC_VECTOR(7 downto 0);
signal sig_adr_case : STD_LOGIC_VECTOR(10 downto 0);
signal sig_data_out_old : STD_LOGIC_VECTOR(7 downto 0);
begin

RAMs : RAMs_graphique 
    port map (clk, rst, CE, 
              enable_mem, enable_cpt, init_cpt_addr_ram, 
              sig_adr_case, 
              sig_RAM_0, sig_RAM_2, sig_RAM_4, sig_RAM_8, sig_RAM_16, sig_RAM_32, sig_RAM_64, sig_RAM_128, sig_RAM_256, sig_RAM_512, sig_RAM_1024, sig_RAM_2048); 

MUX : MUX_ram_conv_image 
    port map( value_in,
              sig_RAM_0, sig_RAM_2, sig_RAM_4, sig_RAM_8, sig_RAM_16, sig_RAM_32, sig_RAM_64, sig_RAM_128, sig_RAM_256, sig_RAM_512, sig_RAM_1024, sig_RAM_2048,
              sig_data_out_old);
              
conv_addr : adresseur
    port map( clk, rst,
              init_adresseur,
              index_in,
              sig_adr_case,
              addr_out);

    process(clk, rst)
    begin
        if rst = '0' then
            sig_data_out_old <= sig_data_out_old;
        elsif clk'event and clk = '1' then
            data_out <= sig_data_out_old;
        end if;
    end process;
end Behavioral;


