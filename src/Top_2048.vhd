----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2021 08:45:41
-- Design Name: 
-- Module Name: Top_2048 - Behavioral
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

entity Top_2048 is
    Port (  clk         : in STD_LOGIC;
            rst         : in STD_LOGIC;
            btn_haut    : in STD_LOGIC;
            btn_bas     : in STD_LOGIC;
            btn_droit   : in STD_LOGIC;
            btn_gauche  : in STD_LOGIC;
            
            LED         : out STD_LOGIC_VECTOR(3 downto 0);
            VGA_hs       : out STD_LOGIC;   -- horisontal vga syncr.
            VGA_vs       : out STD_LOGIC;   -- vertical vga syncr.
            VGA_red      : out STD_LOGIC_VECTOR(3 downto 0);    -- red output
            VGA_green    : out STD_LOGIC_VECTOR(3 downto 0);    -- green output
            VGA_blue     : out STD_LOGIC_VECTOR(3 downto 0));   -- blue output);
           
end Top_2048;

architecture Behavioral of Top_2048 is

component process_2048 is
  Port (   CLK, RST, CE             : in std_logic;

	       btn_haut                 : in std_logic;
           btn_bas                  : in std_logic;
	       btn_droit                : in std_logic;
	       btn_gauche               : in std_logic;
	       
	       addr_write_export        : out std_logic_vector(3 downto 0);
	       data_out_export          : out std_logic_vector(11 downto 0);
	       w_enable_export          : out std_logic);
end component;

component top_graphics is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           CE  : in STD_LOGIC;
           CE_vga : in STD_LOGIC;

           index_in      : in STD_LOGIC_VECTOR  (3 downto 0);
           value_in      : in STD_LOGIC_VECTOR  (11 downto 0);
            
           VGA_hs       : out STD_LOGIC;   -- horisontal vga syncr.
           VGA_vs       : out STD_LOGIC;   -- vertical vga syncr.
           VGA_red      : out STD_LOGIC_VECTOR(3 downto 0);   -- red output
           VGA_green    : out STD_LOGIC_VECTOR(3 downto 0);   -- green output
           VGA_blue     : out STD_LOGIC_VECTOR(3 downto 0)    -- blue output);
           );
end component;

component RAm_double_acces_partage is
 
    Port ( clk              : in    STD_LOGIC;
           CE               : in    STD_LOGIC;
           enable_writing   : in    STD_LOGIC;
           adr_out          : in    STD_LOGIC_VECTOR(3 downto 0);
           adr_in           : in    STD_LOGIC_VECTOR(3 downto 0);
           
           data_in          : in    STD_LOGIC_VECTOR(11 downto 0);
           data_out         : out   STD_LOGIC_VECTOR(11 downto 0));
end component;

component cpt_ram_partage is
    Port ( clk, rst, CE     :   in  STD_LOGIC;
           cpt_en           :   in  STD_LOGIC;
           data_out         :   out STD_LOGIC_VECTOR (3 downto 0));
end component;

component clk_div is
    Port ( clk, rst     :   in  STD_LOGIC;
           CE_VGA       :   out STD_LOGIC;
           CE_addr      :   out STD_LOGIC);
end component;

signal CE_VGA, CE_ADDR, CE_PROCESS      : std_logic;
signal sig_CE               : std_logic;

signal addr_write_export    : std_logic_vector(3 downto 0);
signal data_out_export      : std_logic_vector(11 downto 0);
signal w_enable_export      : std_logic;

signal addr_read            : STD_LOGIC_VECTOR (3 downto 0);
signal data_grid            : STD_LOGIC_VECTOR (11 downto 0);
begin

Graphisme : top_graphics
    Port map(   clk         => clk,
                rst         => rst,
                CE          => sig_CE,
                CE_vga      => CE_vga,
                index_in    => addr_read,  
                value_in    => data_grid,
                   
                VGA_hs      => VGA_hs,
                VGA_vs      => VGA_vs,
                VGA_red     => VGA_red,
                VGA_green   => VGA_green,
                VGA_blue    => VGA_blue);

Calcul : process_2048 
    Port map (  clk         => clk,
                rst         => rst,
                CE          => sig_CE,
                
                btn_haut    => btn_haut,
                btn_bas     => btn_bas,
                btn_gauche  => btn_gauche,
                btn_droit   => btn_droit,
            
                addr_write_export => addr_write_export,
                data_out_export   => data_out_export,
                w_enable_export   => w_enable_export);
                
RAM_partage : RAm_double_acces_partage 
 
    Port map ( clk         => clk,
               CE          => sig_CE,
               
               enable_writing => w_enable_export,
               adr_out        => addr_read,
               adr_in         => addr_write_export,
               
               data_in        => data_out_export,
               data_out       => data_grid);
               
cpt_addr : cpt_ram_partage 
    Port map (  clk         => clk,
                rst         => rst,
                CE          => CE_ADDR,
                
                cpt_en      => '1',
                data_out    => addr_read);
                
Clock_divider : clk_div 
    Port map ( clk         => clk,
               rst         => rst,
               CE_VGA      => CE_VGA, 
               CE_addr     => CE_ADDR);
   
sig_CE <= '1';             
LED(0) <= btn_haut;   
LED(1) <= btn_bas;  
LED(2) <= btn_droit;               
LED(3) <= btn_gauche;               

             
            
end Behavioral;
