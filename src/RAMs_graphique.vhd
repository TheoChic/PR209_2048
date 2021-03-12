----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 16:03:42
-- Design Name: 
-- Module Name: RAMs_graphique - Behavioral
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

entity RAMs_graphique is
    Port (  clk     :   in STD_LOGIC;
            rst     :   in STD_LOGIC;
            CE      :   in STD_LOGIC;
            
            enable_mem  :   in STD_LOGIC;
            enable_cpt  :   in STD_LOGIC;
            cpt_init    :   in STD_LOGIC;
            
            adr_out :   out STD_LOGIC_VECTOR (8 downto 0);
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
end RAMs_graphique;

architecture Behavioral of RAMs_graphique is

    component compteur is
        Port ( clk, rst, CE :   in      STD_LOGIC;
               enable       :   in      STD_LOGIC;
               init         :   in      STD_LOGIC;
               data_Out     :   out     STD_LOGIC_VECTOR (8 downto 0)
               );
    end component;       

    component RAM_20x20_0 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_2 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component RAM_20x20_4 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_8 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_16 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_32 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_64 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_128 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_256 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_512 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_1024 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component RAM_20x20_2048 is 
        Port ( clk      : in    STD_LOGIC;
               CE       : in    STD_LOGIC;
               enable   : in    STD_LOGIC;
               adr      : in    STD_LOGIC_VECTOR(8 downto 0);
               data_out : out   STD_LOGIC_VECTOR(7 downto 0));
    end component;

    signal sig_cpt_adr  : STD_LOGIC_VECTOR(8 downto 0);    
    
begin

RAM_0_component     : RAM_20x20_0       port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_0);
RAM_2_component     : RAM_20x20_2       port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_2);
RAM_4_component     : RAM_20x20_4       port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_4);
RAM_8_component     : RAM_20x20_8       port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_8);
RAM_16_component    : RAM_20x20_16      port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_16);
RAM_32_component    : RAM_20x20_32      port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_32);
RAM_64_component    : RAM_20x20_64      port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_64);
RAM_128_component   : RAM_20x20_128     port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_128);
RAM_256_component   : RAM_20x20_256     port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_256);
RAM_512_component   : RAM_20x20_512     port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_512);
RAM_1024_component  : RAM_20x20_1024    port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_1024);
RAM_2048_component  : RAM_20x20_2048    port map ( clk, CE, enable_mem, sig_cpt_adr, RAM_2048);
cpt_adr             : compteur          port map ( clk, rst, CE, enable_cpt, cpt_init, sig_cpt_adr);

adr_out <= sig_cpt_adr;

end Behavioral;
