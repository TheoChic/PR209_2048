----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2021 13:45:14
-- Design Name: 
-- Module Name: test_conv_grid - Behavioral
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
use IEEE.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_graphics is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           CE :  in STD_LOGIC;
           
           index_in      : in STD_LOGIC_VECTOR  (3 downto 0);
           value_in      : in STD_LOGIC_VECTOR  (11 downto 0);
            
           VGA_hs       : out STD_LOGIC;   -- horisontal vga syncr.
           VGA_vs       : out STD_LOGIC;   -- vertical vga syncr.
           VGA_red      : out STD_LOGIC_VECTOR(3 downto 0);   -- red output
           VGA_green    : out STD_LOGIC_VECTOR(3 downto 0);   -- green output
           VGA_blue     : out STD_LOGIC_VECTOR(3 downto 0)    -- blue output);
           );
           
end top_graphics;

architecture Behavioral of top_graphics is

component conv_grid_to_img 
    Port ( clk, rst, CE : in STD_LOGIC;
           index_in     : in STD_LOGIC_VECTOR (3 downto 0);
           value_in     : in STD_LOGIC_VECTOR (11 downto 0);
           
           enable_mem, enable_cpt   :   in STD_LOGIC;
           init_cpt_addr_ram : in STD_LOGIC;    
           init_adresseur : in STD_LOGIC;  
                
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           addr_out : out STD_LOGIC_VECTOR (16 downto 0));
end component;

component RAM_double_acces
    Port ( clk              : in    STD_LOGIC;
           CE               : in    STD_LOGIC;
           enable_writing   : in    STD_LOGIC;
           adr_out          : in    STD_LOGIC_VECTOR(16 downto 0);
           adr_in           : in    STD_LOGIC_VECTOR(16 downto 0);
           data_in          : in    STD_LOGIC_VECTOR(7 downto 0);
           data_out         : out   STD_LOGIC_VECTOR(7 downto 0));
end component;

component cpt_addr_screen
    Port ( clk, rst, CE :   in      STD_LOGIC;
           enable       :   in      STD_LOGIC;
           init         :   in      STD_LOGIC;
           data_Out     :   out     STD_LOGIC_VECTOR (16 downto 0)
           );
end component;
      
component VGA_bitmap_320x240
    generic(    bit_per_pixel : integer range 1 to 12:=8;    -- number of bits per pixel
                grayscale     : boolean := false);
                
	port(  clk          : in  std_logic;
           reset        : in  std_logic;
           VGA_hs       : out std_logic;   -- horisontal vga syncr.
           VGA_vs       : out std_logic;   -- vertical vga syncr.
           VGA_red      : out std_logic_vector(3 downto 0);   -- red output
           VGA_green    : out std_logic_vector(3 downto 0);   -- green output
           VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output
    
           ADDR         : in  std_logic_vector(16 downto 0);
           data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
           data_write   : in  std_logic;
           data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component;

constant cst : integer :=4;


signal sig_CE : std_logic ;
signal index : std_logic_vector(3 downto 0);
signal value : std_logic_vector(11 downto 0);
signal data_to_RAM, data_to_VGA : std_logic_vector(7 downto 0);

signal addr_grid :       std_logic_vector(16 downto 0);
signal addr_screen :    std_logic_vector(16 downto 0);

signal init_adresseur, init_cpt_addr_ram_conv, init_cpt_addr_ram, enable_mem, enable_cpt, enable_cpt_ram, data_write, enable_writing : std_logic;--signaux configurés par la FSM
signal data_out : std_logic_vector( 7 downto 0); --poubelle

signal cpt : integer range 0 to (13400*cst) := 0;

signal reset : std_logic;
begin
    conv_grid : conv_grid_to_img   
        port map(clk, rst, sig_CE, index_in, value_in, enable_mem, enable_cpt, init_cpt_addr_ram_conv, init_adresseur, data_to_RAM, addr_grid);
        
    RAM_screen : RAM_double_acces
        port map(clk, sig_CE, enable_writing, addr_screen, addr_grid, data_to_RAM, data_to_VGA);
        
    cpt_addr_vga : cpt_addr_screen
        port map(clk, rst, sig_CE, enable_cpt_ram, init_cpt_addr_ram, addr_screen);
        
    VGA : VGA_bitmap_320x240
        port map(clk, reset, VGA_hs, VGA_vs, VGA_red, VGA_green, VGA_blue, addr_screen, data_to_VGA, data_write, data_out);
    
reset <= not(rst);
    

sig_CE <= CE;
enable_mem <= '1';
enable_cpt <= '1';
enable_cpt_ram <= '1';
data_write <= '1';
enable_writing <= '1';

end Behavioral;
